# [Usage]
# $ gem install raylib-bindings-tileson
# $ ruby raylib_with_tileson.rb

require 'raylib'
require 'tileson'

if __FILE__ == $PROGRAM_NAME
  shared_lib_suffix = case RUBY_PLATFORM
                      when /mswin|msys|mingw/
                        'dll'
                      when /darwin/
                        arch = RUBY_PLATFORM.split('-')[0]
                        "#{arch}.dylib"
                      when /linux/
                        arch = RUBY_PLATFORM.split('-')[0]
                        "#{arch}.so"
                      else
                        raise RuntimeError, "Unknown OS: #{RUBY_PLATFORM}"
                      end

  raylib_spec = Gem::Specification.find_by_name('raylib-bindings')
  shared_lib_path = raylib_spec.full_gem_path + '/lib/'
  Raylib.load_lib("#{shared_lib_path}libraylib.#{shared_lib_suffix}")

  tileson_spec = Gem::Specification.find_by_name('raylib-bindings-tileson')
  shared_lib_path = tileson_spec.full_gem_path + '/lib/'
  Raylib.load_tileson_lib("#{shared_lib_path}tileson.#{shared_lib_suffix}")

  screen_width = 500
  screen_height = 290

  Raylib.InitWindow(screen_width, screen_height, "Ruby raylib+tileson")
  Raylib.SetTargetFPS(60)

  map = Raylib.LoadTiled("map/sampleMap.tmj")

  until Raylib.WindowShouldClose()
    Raylib.BeginDrawing()
      Raylib.ClearBackground(Raylib::RAYWHITE)
      Raylib.DrawTiled(map, 10.0, 8.0, Raylib::WHITE)
    Raylib.EndDrawing()
  end

  Raylib.UnloadMap(map)
  Raylib.CloseWindow()
end
