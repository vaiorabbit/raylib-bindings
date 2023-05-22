require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, 'Yet Another Ruby-raylib bindings - procedural images generation')

  images = [
    GenImageGradientLinear(screenWidth, screenHeight, 0, RED, BLUE),      # verticalGradient
    GenImageGradientLinear(screenWidth, screenHeight, 90, RED, BLUE),     # horizontalGradient
    GenImageGradientLinear(screenWidth, screenHeight, 45, RED, BLUE),     # diagonalGradient
    GenImageGradientRadial(screenWidth, screenHeight, 0.0, WHITE, BLACK), # radialGradient
    GenImageGradientSquare(screenWidth, screenHeight, 0.0, WHITE, BLACK), # squareGradient
    GenImageChecked(screenWidth, screenHeight, 32, 32, RED, BLUE),        # checked
    GenImageWhiteNoise(screenWidth, screenHeight, 0.5),                   # whiteNoise
    GenImagePerlinNoise(screenWidth, screenHeight, 50, 50, 4.0),          # perlinNoise
    GenImageCellular(screenWidth, screenHeight, 32),                      # rkcellular
  ]

  textures = []
  images.each { |image| textures << LoadTextureFromImage(image) }
  images.each { |image| UnloadImage(image) } # Unload image data (CPU RAM)

  currentTexture = 0

  SetTargetFPS(60)

  until WindowShouldClose()

    if IsMouseButtonPressed(MOUSE_BUTTON_LEFT) || IsKeyPressed(KEY_RIGHT)
      currentTexture = (currentTexture + 1) % textures.length # Cycle between the textures
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)

      DrawTexture(textures[currentTexture], 0, 0, WHITE)

      DrawRectangle(30, 400, 325, 30, Fade(SKYBLUE, 0.5))
      DrawRectangleLines(30, 400, 325, 30, Fade(WHITE, 0.5))
      DrawText("MOUSE LEFT BUTTON to CYCLE PROCEDURAL TEXTURES", 40, 410, 10, WHITE)

      case currentTexture
      when 0; DrawText("VERTICAL GRADIENT", 560, 10, 20, RAYWHITE)
      when 1; DrawText("HORIZONTAL GRADIENT", 540, 10, 20, RAYWHITE)
      when 2; DrawText("DIAGONAL GRADIENT", 540, 10, 20, RAYWHITE)
      when 3; DrawText("RADIAL GRADIENT", 580, 10, 20, LIGHTGRAY)
      when 4; DrawText("SQUARE GRADIENT", 580, 10, 20, LIGHTGRAY)
      when 5; DrawText("CHECKED", 680, 10, 20, RAYWHITE)
      when 6; DrawText("WHITE NOISE", 640, 10, 20, RED)
      when 7; DrawText("PERLIN NOISE", 640, 10, 20, RED)
      when 8; DrawText("CELLULAR", 670, 10, 20, RAYWHITE)
      end

    EndDrawing()
  end

  textures.each { |texture| UnloadTexture(texture) } # Unload textures data (GPU VRAM)

  CloseWindow()
end
