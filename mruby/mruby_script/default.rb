# Sample usage
=begin
MRuby::CrossBuild.new('emscripten') do |conf|
  toolchain :emscripten
  # conf.gem :github => 'mattn/mruby-onig-regexp'
  # conf.gem :github => 'take-cheeze/mruby-marshal'
  conf.gembox 'default'

   conf.cc do |cc|
     cc.flags = [ENV['CFLAGS'] || %w()]
     cc.compile_options = "%{flags} -O3 -MMD -o %{outfile} -c %{infile} -I$HOME/dev/onig/src"
     # cc.defines = %w(MRB_INTEGER_DIVISION)
   end

   # conf.cxx.defines = %w(MRB_INTEGER_DIVISION)

  conf.linker.command = 'emcc'
end
=end

MRuby::CrossBuild.new('emscripten') do |conf|
  toolchain :clang
  conf.gembox 'default'
  conf.cc.command = 'emcc'
  conf.cc.flags = %W(-Os)
  conf.linker.command = 'emcc'
  conf.archiver.command = 'emar'
end
