# coding: utf-8
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

  fonts = [
    LoadFontEx("jpfont/GenShinGothic-Normal.ttf", 20, nil, 65535),
    LoadFontEx("jpfont/x12y16pxMaruMonica.ttf", 16, nil, 65535),
  ]

  font_names = [
    "源真ゴシック",
    "マルモニカ",
  ]

  SetTextureFilter(fonts[0][:texture], TEXTURE_FILTER_BILINEAR) # 源真ゴシック
  SetTextureFilter(fonts[1][:texture], TEXTURE_FILTER_POINT)    # マルモニカ

  # fonts.each { |font| GenTextureMipmaps(font[:texture].pointer) }

  NUM_FONTS = fonts.length
  current_font = 0

  until WindowShouldClose()
    BeginDrawing()
      ClearBackground(RAYWHITE)
      if IsKeyReleased(KEY_RIGHT)
        current_font += 1
        current_font = 0 if current_font == NUM_FONTS
      elsif IsKeyReleased(KEY_LEFT)
        current_font -= 1
        current_font = NUM_FONTS - 1 if current_font < 0
      end
      DrawTextEx(fonts[current_font], msg.join, Vector2.create(20.0, 50.0), fonts[current_font][:baseSize].to_f, 1.2, DARKGREEN)

      DrawRectangle(650, 400, 125, 25, Fade(SKYBLUE, 0.5))
      DrawRectangleLines(650, 400, 125, 25, Fade(DARKBLUE, 0.5))
      DrawTextEx(fonts[current_font], "Font : #{font_names[current_font]}", Vector2.create(660, 405), 16.0, 1.0, BLUE)
    EndDrawing()
  end

  CloseWindow()
end
