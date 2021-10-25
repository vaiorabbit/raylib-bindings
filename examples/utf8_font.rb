require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  InitWindow(800, 450, "Yet Another Ruby-raylib bindings - UTF8 font")
  SetTargetFPS(60)

  msg = []
  IO.readlines('./jpfont/jpfont.txt').each do |line|
    if line.length > 50
      line.chars.each_slice(50) do |slice|
        msg << slice.join + "\n"
      end
    else
      msg << line
    end
  end

  fontTtf = LoadFontEx("jpfont/GenShinGothic-Normal.ttf", 20, nil, 65535);

  until WindowShouldClose()
    BeginDrawing()
    ClearBackground(RAYWHITE)
    DrawTextEx(fontTtf, msg.join, Vector2.create(20.0, 50.0), fontTtf[:baseSize].to_f, 1.2, DARKGREEN)
    EndDrawing()
  end

  CloseWindow()
end
