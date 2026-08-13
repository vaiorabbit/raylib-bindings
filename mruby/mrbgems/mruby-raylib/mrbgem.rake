MRuby::Gem::Specification.new('mruby-raylib') do |spec|
  spec.license = 'Zlib'
  spec.authors = ['vaiorabbit']
  spec.summary = 'raylib bindings for mruby'

  raylib_root = ENV['RAYLIB_ROOT'] || File.expand_path('../../third_party/raylib', __dir__)
  raylib_include = File.join(raylib_root, 'include')
  raylib_lib = File.join(raylib_root, 'lib')

  for_wasm = ENV['BUILD_FOR_WASM'] != nil

  unless File.exist?(File.join(raylib_include, 'raylib.h'))
    raise "raylib headers not found: #{raylib_include}"
  end

  if for_wasm or !spec.for_windows?
    unless File.exist?(File.join(raylib_lib, 'libraylib.a'))
      raise "raylib library not found: #{File.join(raylib_lib, 'libraylib.a')}"
    end
  else ## if spec.for_windows?
    unless File.exist?(File.join(raylib_lib, 'raylib.lib'))
      raise "raylib library not found: #{File.join(raylib_lib, 'raylib.lib')}"
    end
  end    

  spec.cc.include_paths << raylib_include
  spec.linker.library_paths << raylib_lib
  spec.linker.libraries << 'raylib'

  spec.build.defines << "HAVE_MRUBY_RAYLIB_GEM"

  if spec.for_windows?
    spec.linker.libraries.concat(%w(opengl32 glu32 winmm user32 gdi32 shell32))
  end
end
