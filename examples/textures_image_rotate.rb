require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - texture rotation")

  # NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
  image45 = LoadImage(RAYLIB_TEXTURE_PATH + "resources/raylib_logo.png")
  image90 = LoadImage(RAYLIB_TEXTURE_PATH + "resources/raylib_logo.png")
  imageNeg90 = LoadImage(RAYLIB_TEXTURE_PATH + "resources/raylib_logo.png")

  ImageRotate(image45, 45)
  ImageRotate(image90, 90)
  ImageRotate(imageNeg90, -90)

  textures = [
    LoadTextureFromImage(image45),
    LoadTextureFromImage(image90),
    LoadTextureFromImage(imageNeg90),
  ]

  currentTexture = 0

  until WindowShouldClose()
    currentTexture = (currentTexture + 1) % textures.length if IsMouseButtonPressed(MOUSE_BUTTON_LEFT) || IsKeyPressed(KEY_RIGHT)
    BeginDrawing()
      ClearBackground(RAYWHITE)
      DrawTexture(textures[currentTexture], screenWidth / 2 - textures[currentTexture].width/2, screenHeight/2 - textures[currentTexture].height/2, WHITE)
    EndDrawing()
  end

  textures.each { |texture| UnloadTexture(texture) }

  CloseWindow()

end
