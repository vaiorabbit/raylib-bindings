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

  s = Gem::Specification.find_by_name('raylib-bindings')
  shared_lib_path = s.full_gem_path + '/lib/'

  case RUBY_PLATFORM
  when /mswin|msys|mingw|cygwin/
    Raylib.load_lib(shared_lib_path + 'libraylib.dll', raygui_libpath: shared_lib_path + 'raygui.dll', physac_libpath: shared_lib_path + 'physac.dll')
  when /darwin/
    Raylib.load_lib(shared_lib_path + 'libraylib.dylib', raygui_libpath: shared_lib_path + 'raygui.dylib', physac_libpath: shared_lib_path + 'physac.dylib')
  when /linux/
    arch = RUBY_PLATFORM.split('-')[0]
    Raylib.load_lib(shared_lib_path + "libraylib.#{arch}.so", raygui_libpath: shared_lib_path + "libraygui.#{arch}.so", physac_libpath: shared_lib_path + "libphysac.#{arch}.so")
  else
    raise RuntimeError, "setup_dll.rb : Unknown OS: #{RUBY_PLATFORM}"
  end
else
  # puts("Loaging from local path.")
  require '../lib/raylib'

  case RUBY_PLATFORM
  when /mswin|msys|mingw|cygwin/
    Raylib.load_lib(Dir.pwd + '/../lib/' + 'libraylib.dll', raygui_libpath: Dir.pwd + '/../lib/' + 'raygui.dll', physac_libpath: Dir.pwd + '/../lib/' + 'physac.dll')
  when /darwin/
    Raylib.load_lib(Dir.pwd + '/../lib/' + 'libraylib.dylib', raygui_libpath: Dir.pwd + '/../lib/' + 'raygui.dylib', physac_libpath: Dir.pwd + '/../lib/' + 'physac.dylib')
  when /linux/
    arch = RUBY_PLATFORM.split('-')[0]
    Raylib.load_lib(Dir.pwd + '/../lib/' + "libraylib.#{arch}.so", raygui_libpath: Dir.pwd + '/../lib/' + "raygui.#{arch}.so", physac_libpath: Dir.pwd + '/../lib/' + "physac.#{arch}.so")
  else
    raise RuntimeError, "setup_dll.rb : Unknown OS: #{RUBY_PLATFORM}"
  end
end

include Raylib

