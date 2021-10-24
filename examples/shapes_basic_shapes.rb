require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - basic shapes drawing")
  SetTargetFPS(60)

  until WindowShouldClose()
    BeginDrawing()
    ClearBackground(RAYWHITE)
    DrawText("some basic shapes available on raylib", 20, 20, 20, DARKGRAY)

    # Circle shapes and lines
    DrawCircle(screenWidth/5, 120, 35, SKYBLUE)
    DrawCircleGradient(screenWidth/5, 220, 60, GREEN, SKYBLUE)
    DrawCircleLines(screenWidth/5, 340, 80, DARKBLUE)

    EndDrawing()
  end

  CloseWindow()
end
