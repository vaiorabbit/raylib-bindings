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
    DrawCircle(screenWidth/5, 120, 35, DARKBLUE)
    DrawCircleGradient(screenWidth/5, 220, 60, GREEN, SKYBLUE)
    DrawCircleLines(screenWidth/5, 340, 80, DARKBLUE)

    # Rectangle shapes and ines
    DrawRectangle(screenWidth/4*2 - 60, 100, 120, 60, RED)
    DrawRectangleGradientH(screenWidth/4*2 - 90, 170, 180, 130, MAROON, GOLD)
    DrawRectangleLines(screenWidth/4*2 - 40, 320, 80, 60, ORANGE)  # NOTE: Uses QUADS internally, not lines

    # Triangle shapes and lines
    DrawTriangle(Vector2.create(screenWidth/4.0 *3.0, 80.0),
                 Vector2.create(screenWidth/4.0 *3.0 - 60.0, 150.0),
                 Vector2.create(screenWidth/4.0 *3.0 + 60.0, 150.0), VIOLET)

    DrawTriangleLines(Vector2.create(screenWidth/4.0*3.0, 160.0),
                      Vector2.create(screenWidth/4.0*3.0 - 20.0, 230.0),
                      Vector2.create(screenWidth/4.0*3.0 + 20.0, 230.0), DARKBLUE)

    # Polygon shapes and lines
    DrawPoly(Vector2.create(screenWidth/4*3, 320), 6, 80, 0, BROWN)
    DrawPolyLinesEx(Vector2.create(screenWidth/4*3, 320), 6, 80, 0, 6, BEIGE)

    # NOTE: We draw all LINES based shapes together to optimize internal drawing,
    # this way, all LINES are rendered in a single draw pass
    DrawLine(18, 42, screenWidth - 18, 42, BLACK)

    EndDrawing()
  end

  CloseWindow()
end
