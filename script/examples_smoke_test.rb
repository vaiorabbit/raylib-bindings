#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'rbconfig'
require 'tmpdir'

DEFAULT_TIMEOUT_SECONDS = 5.0
DEFAULT_GRACE_SECONDS = 1.5
DEFAULT_ALLOWLIST = 'examples/smoke_allowlist.txt'

def windows_platform?
  (/mswin|mingw|cygwin/ =~ RbConfig::CONFIG['host_os']) != nil
end

def parse_args(repo_root)
  options = {
    timeout: DEFAULT_TIMEOUT_SECONDS,
    grace: DEFAULT_GRACE_SECONDS,
    allowlist: File.expand_path(DEFAULT_ALLOWLIST, repo_root),
    verbose: false,
    list_only: false,
    max_examples: nil
  }

  parser = OptionParser.new do |opts|
    opts.banner = 'Usage: ruby script/examples_smoke_test.rb [options]'

    opts.on('--timeout SECONDS', Float, "Per-example runtime before termination (default: #{DEFAULT_TIMEOUT_SECONDS})") do |seconds|
      raise OptionParser::InvalidArgument, 'timeout must be > 0' unless seconds.positive?

      options[:timeout] = seconds
    end

    opts.on('--grace SECONDS', Float, "Grace period after TERM before KILL (default: #{DEFAULT_GRACE_SECONDS})") do |seconds|
      raise OptionParser::InvalidArgument, 'grace must be >= 0' if seconds.negative?

      options[:grace] = seconds
    end

    opts.on('--allowlist PATH', String, 'Path to explicit allowlist file') do |path|
      options[:allowlist] = File.expand_path(path, Dir.pwd)
    end

    opts.on('--max N', Integer, 'Run only the first N examples (debug aid)') do |count|
      raise OptionParser::InvalidArgument, 'max must be > 0' unless count.positive?

      options[:max_examples] = count
    end

    opts.on('--list', 'Print resolved allowlist and exit') do
      options[:list_only] = true
    end

    opts.on('--verbose', 'Print command details and error output for failures') do
      options[:verbose] = true
    end
  end

  parser.parse!
  options
rescue OptionParser::ParseError => e
  warn("[error] #{e.message}")
  warn(parser)
  exit(2)
end

def load_allowlist(repo_root, allowlist_path)
  raise "Allowlist not found: #{allowlist_path}" unless File.file?(allowlist_path)

  lines = File.readlines(allowlist_path, chomp: true)
  entries = lines
            .map(&:strip)
            .reject { |line| line.empty? || line.start_with?('#') }

  if entries.empty?
    raise "Allowlist is empty: #{allowlist_path}"
  end

  entries.map do |entry|
    resolved = File.expand_path(entry, repo_root)
    unless resolved.start_with?(repo_root + File::SEPARATOR)
      raise "Allowlist entry escapes repository root: #{entry}"
    end
    raise "Example not found: #{entry}" unless File.file?(resolved)

    resolved
  end
end

def wait_for_exit(pid, deadline)
  loop do
    begin
      waited_pid, status = Process.waitpid2(pid, Process::WNOHANG)
      return status if waited_pid
    rescue Errno::ECHILD
      return nil
    end

    return nil if Time.now >= deadline

    sleep(0.05)
  end
end

def terminate_process(pid, grace_seconds)
  first_signal = windows_platform? ? 'KILL' : 'TERM'

  begin
    Process.kill(first_signal, pid)
  rescue Errno::ESRCH
    return
  rescue Errno::EINVAL
    Process.kill('KILL', pid)
    return
  end

  status = wait_for_exit(pid, Time.now + grace_seconds)
  return if status

  begin
    Process.kill('KILL', pid)
  rescue Errno::ESRCH
    return
  end

  begin
    Process.wait(pid)
  rescue Errno::ECHILD
    nil
  end
end

def run_example(example_path, timeout_seconds, grace_seconds, verbose)
  started = Time.now
  spawn_cmd = [RbConfig.ruby, File.basename(example_path)]
  output_path = File.join(Dir.tmpdir, "examples_smoke_#{Process.pid}_#{File.basename(example_path, '.rb')}.log")

  if verbose
    puts("[run] #{spawn_cmd.join(' ')} (chdir=#{File.dirname(example_path)})")
  end

  begin
    pid = Process.spawn(*spawn_cmd, chdir: File.dirname(example_path), out: output_path, err: output_path)
  rescue StandardError => e
    return {
      status: 'spawn-failed',
      duration: Time.now - started,
      message: "#{e.class}: #{e.message}",
      log_path: output_path
    }
  end

  process_status = wait_for_exit(pid, Time.now + timeout_seconds)

  if process_status
    status = process_status.exitstatus == 0 ? 'pass' : 'nonzero-exit'
  else
    terminate_process(pid, grace_seconds)
    status = 'timeout-terminated'
  end

  result = {
    status: status,
    duration: Time.now - started,
    exitstatus: process_status&.exitstatus,
    termsig: process_status&.termsig,
    log_path: output_path
  }

  if verbose && status == 'nonzero-exit' && File.file?(output_path)
    log = File.read(output_path)
    unless log.empty?
      puts('[verbose] --- begin child output ---')
      puts(log.lines.last(40).join)
      puts('[verbose] --- end child output ---')
    end
  end

  if status != 'nonzero-exit' && File.file?(output_path)
    File.delete(output_path)
    result[:log_path] = nil
  end

  result
end

def print_result(example_rel, result)
  marker = case result[:status]
           when 'pass' then 'PASS'
           when 'timeout-terminated' then 'TIMEOUT'
           when 'nonzero-exit' then 'FAIL'
           else 'ERROR'
           end

  details = []
  details << format('%.2fs', result[:duration])
  details << "exit=#{result[:exitstatus]}" if result.key?(:exitstatus) && !result[:exitstatus].nil?
  details << "signal=#{result[:termsig]}" if result.key?(:termsig) && !result[:termsig].nil?
  details << result[:message] if result[:message]
  details << "log=#{result[:log_path]}" if result[:log_path]

  puts(format('[%-7s] %-45s %s', marker, example_rel, details.join(', ')))
end

def summarize(results)
  counts = Hash.new(0)
  results.each { |r| counts[r[:status]] += 1 }

  puts
  puts('Summary:')
  puts("  total:              #{results.size}")
  puts("  pass:               #{counts['pass']}")
  puts("  timeout-terminated: #{counts['timeout-terminated']}")
  puts("  nonzero-exit:       #{counts['nonzero-exit']}")
  puts("  spawn-failed:       #{counts['spawn-failed']}")

  failing = counts['nonzero-exit'] + counts['spawn-failed']
  puts("  final status:       #{failing.zero? ? 'SUCCESS' : 'FAILURE'}")

  failing.zero? ? 0 : 1
end

repo_root = File.expand_path('..', __dir__)
options = parse_args(repo_root)
allowlisted = load_allowlist(repo_root, options[:allowlist])
allowlisted = allowlisted.first(options[:max_examples]) if options[:max_examples]

if options[:list_only]
  puts("Allowlist: #{options[:allowlist]}")
  allowlisted.each { |path| puts(path.delete_prefix(repo_root + File::SEPARATOR).tr('\\\\', '/')) }
  puts("Count: #{allowlisted.size}")
  exit(0)
end

puts("Running #{allowlisted.size} example(s) with timeout=#{options[:timeout]}s")
results = []

allowlisted.each do |path|
  rel = path.delete_prefix(repo_root + File::SEPARATOR).tr('\\\\', '/')
  result = run_example(path, options[:timeout], options[:grace], options[:verbose])
  results << result.merge(example: rel)
  print_result(rel, result)
end

exit(summarize(results))
