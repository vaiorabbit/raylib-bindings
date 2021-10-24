def raylib_bindings_gem_available?
  Gem::Specification.find_by_name('raylib-bindings')
rescue Gem::LoadError
  false
rescue
  Gem.available?('raylib-bindings')
end

if raylib_bindings_gem_available?
  # puts("Loading from Gem system path.")
  require 'raylib'
else
  # puts("Loaging from local path.")
  require '../lib/raylib'
end

include Raylib

case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  Raylib.load_lib(Dir.pwd + '/../lib/' + 'raylib.dll')
when /darwin/
  Raylib.load_lib(Dir.pwd + '/../lib/' + 'libraylib.dylib')
when /linux/
  Raylib.load_lib(Dir.pwd + '/../lib/' + 'libraylib.so')
else
  raise RuntimeError, "setup_dll.rb : Unknown OS: #{RUBY_PLATFORM}"
end
