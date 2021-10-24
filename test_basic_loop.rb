require_relative 'lib/raylib'
#require_relative 'raylib'

$lib_path = case RUBY_PLATFORM
            when /mswin|msys|mingw|cygwin/
              Dir.pwd + '/' + 'raylib.dll'
            when /darwin/
              'libraylib.dylib'
            when /linux/
              'libraylib.so'
            else
              raise RuntimeError, "test.rb : Unknown OS: #{RUBY_PLATFORM}"
            end

Raylib.load_lib($lib_path)

include Raylib

if __FILE__ == $0
  InitWindow(800, 450, "Yet Another Ruby-raylib bindings")
  SetTargetFPS(60)

  ray_white = Color.new
  ray_white[:r] = 245
  ray_white[:g] = 245
  ray_white[:b] = 245
  ray_white[:a] = 255

  light_gray = Color.new
  light_gray[:r] = 200
  light_gray[:g] = 200
  light_gray[:b] = 200
  light_gray[:a] = 255

  until WindowShouldClose()
    BeginDrawing()
    ClearBackground(ray_white)
    DrawText("Congrats! You created your first window!", 190, 200, 20, light_gray)
    EndDrawing()
  end

  CloseWindow()
end
