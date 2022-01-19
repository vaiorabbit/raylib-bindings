require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  SetConfigFlags(FLAG_MSAA_4X_HINT)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - cubic-bezier lines")

  curve_start = Vector2.create(0, 0)
  curve_end = Vector2.create(screenWidth.to_f, screenHeight.to_f)

  SetTargetFPS(60)

  until WindowShouldClose()
    if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
      curve_start = GetMousePosition()
    elsif IsMouseButtonDown(MOUSE_BUTTON_RIGHT)
      curve_end = GetMousePosition()
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      DrawText("USE MOUSE LEFT-RIGHT CLICK to DEFINE LINE START and END POINTS", 15, 20, 20, GRAY)
      DrawLineBezier(curve_start, curve_end, 2.0, RED)
    EndDrawing()
  end

  CloseWindow()
end
