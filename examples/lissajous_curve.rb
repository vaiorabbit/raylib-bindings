require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screen_width = 1280
  screen_height = 720

  SetConfigFlags(FLAG_WINDOW_RESIZABLE)
  InitWindow(screen_width, screen_height, "Yet Another Ruby-raylib bindings - Lissajous Curve")

  SetTargetFPS(60)

  highlight_sample = 0
  circle_radius = 10.0

  until WindowShouldClose()
    if IsWindowResized()
      screen_width = GetScreenWidth()
      screen_height = GetScreenHeight()
    end

    sample_count = 10000
    step = 20
    ofs_x = screen_width / 2.0
    ofs_y = screen_height / 2.0
    ampA = 0.8 * [screen_width, screen_height].min / 2.0
    ampB = ampA
    a = 5.0
    b = 4.0
    d = Math::PI / 2.0
    BeginDrawing()
      ClearBackground(DARKGRAY)
      sample_count.times do |i|
        t0 = 2 * Math::PI * (i.to_f / sample_count)
        t1 = 2 * Math::PI * (((i + 1) % sample_count).to_f / sample_count)
        x0 = ampA * Math.sin(a * t0 + d) + ofs_x
        y0 = ampB * Math.sin(b * t0) + ofs_y
        x1 = ampA * Math.sin(a * t1 + d) + ofs_x
        y1 = ampB * Math.sin(b * t1) + ofs_y
        DrawLine(x0, y0, x1, y1, GREEN)
        if i == highlight_sample
          DrawCircle(x0, y0, circle_radius, YELLOW)
        end
      end
      highlight_sample = (highlight_sample + step) % sample_count
      DrawFPS(screen_width - 90, screen_height - 30)
    EndDrawing()
  end

  CloseWindow()
end
