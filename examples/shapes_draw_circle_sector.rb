require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - draw circle sector")

  center = Vector2.create((GetScreenWidth() - 300)/2, GetScreenHeight()/2)

  outerRadius = 180.0
  startAngle = 0.0
  endAngle = 180.0
  segments = 0
  minSegments = 4

  SetTargetFPS(60)

  until WindowShouldClose()
    BeginDrawing()
      ClearBackground(RAYWHITE)
      DrawLine(500, 0, 500, GetScreenHeight(), Fade(LIGHTGRAY, 0.6))
      DrawRectangle(500, 0, GetScreenWidth() - 500, GetScreenHeight(), Fade(LIGHTGRAY, 0.3))

      DrawCircleSector(center, outerRadius, startAngle, endAngle, segments, Fade(MAROON, 0.3))
      DrawCircleSectorLines(center, outerRadius, startAngle, endAngle, segments, Fade(MAROON, 0.6))

      # Draw GUI controls
      #------------------------------------------------------------------------------
      startAngle = RGuiSliderBar(Rectangle.create(600, 40, 120, 20), "StartAngle", nil, startAngle, 0, 720)
      endAngle = RGuiSliderBar(Rectangle.create(600, 70, 120, 20), "EndAngle", nil, endAngle, 0, 720)

      outerRadius = RGuiSliderBar(Rectangle.create(600, 140, 120, 20), "Radius", nil, outerRadius, 0, 200)
      segments = RGuiSliderBar(Rectangle.create(600, 170, 120, 20), "Segments", nil, segments, 0, 100)
      #------------------------------------------------------------------------------

      minSegments = ((endAngle - startAngle) / 90).ceil.to_i
      DrawText(TextFormat("MODE: %s", :string, (segments >= minSegments) ? "MANUAL" : "AUTO"), 600, 200, 10, (segments >= minSegments) ? MAROON : DARKGRAY)

      DrawFPS(10, 10)
    EndDrawing()
  end

  CloseWindow()
end
