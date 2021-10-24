require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
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
