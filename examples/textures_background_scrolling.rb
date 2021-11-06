require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - background scrolling")

  # NOTE: Be careful, background width must be equal or bigger than screen width
  # if not, texture should be draw more than two times for scrolling effect
  background = LoadTexture(RAYLIB_TEXTURE_PATH + "resources/cyberpunk_street_background.png");
  midground = LoadTexture(RAYLIB_TEXTURE_PATH + "resources/cyberpunk_street_midground.png");
  foreground = LoadTexture(RAYLIB_TEXTURE_PATH + "resources/cyberpunk_street_foreground.png");

  scrollingBack = 0.0
  scrollingMid = 0.0
  scrollingFore = 0.0

  SetTargetFPS(60)

  until WindowShouldClose()

    scrollingBack -= 0.1
    scrollingMid -= 0.5
    scrollingFore -= 1.0

    # NOTE: Texture is scaled twice its size, so it sould be considered on scrolling
    scrollingBack = 0 if scrollingBack <= -background[:width]*2
    scrollingMid = 0 if scrollingMid <= -midground[:width]*2
    scrollingFore = 0 if scrollingFore <= -foreground[:width]*2

    BeginDrawing()
      ClearBackground(GetColor(0x052c46ff))
      # Draw background image twice
      # NOTE: Texture is scaled twice its size
      DrawTextureEx(background, Vector2.create(scrollingBack, 20), 0.0, 2.0, WHITE)
      DrawTextureEx(background, Vector2.create(background[:width]*2 + scrollingBack, 20), 0.0, 2.0, WHITE)

      # Draw midground image twice
      DrawTextureEx(midground, Vector2.create(scrollingMid, 20), 0.0, 2.0, WHITE)
      DrawTextureEx(midground, Vector2.create(midground[:width]*2 + scrollingMid, 20), 0.0, 2.0, WHITE)

      # Draw foreground image twice
      DrawTextureEx(foreground, Vector2.create(scrollingFore, 70), 0.0, 2.0, WHITE)
      DrawTextureEx(foreground, Vector2.create(foreground[:width]*2 + scrollingFore, 70), 0.0, 2.0, WHITE)

      DrawText("BACKGROUND SCROLLING & PARALLAX", 10, 10, 20, RED)
      DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", screenWidth - 330, screenHeight - 20, 10, RAYWHITE);
    EndDrawing()
  end

  unloadtexture(background)
  unloadtexture(midground)
  UnloadTexture(foreground)
  CloseWindow()

end
