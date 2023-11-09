require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  GLSL_VERSION = 330

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - SDF fonts")

  # NOTE: Textures/Fonts MUST be loaded after Window initialization (OpenGL context is required)

  msg = 'Signed Distance Fields'

  fileSize = FFI::MemoryPointer.new(:int, 1)
  fileData = LoadFileData(RAYLIB_TEXT_PATH + "resources/anonymous_pro_bold.ttf", fileSize)

  # Default font generation from TTF font
  fontDefault = Font.new
  fontDefault.baseSize = 16
  fontDefault.glyphCount = 95

  # Loading font data from memory data
  # Parameters > font size: 16, no glyphs array provided (0), glyphs count: 95 (autogenerate chars array)
  fontDefault.glyphs = LoadFontData(fileData, fileSize.read_int, 16, nil, 95, FONT_DEFAULT)
  fontDefault_recs_buf = FFI::MemoryPointer.new(:pointer, 1)
  atlas = GenImageFontAtlas(fontDefault.glyphs, fontDefault_recs_buf, 95, 16, 4, 0)
  fontDefault.recs = fontDefault_recs_buf.read_pointer
  fontDefault.texture = LoadTextureFromImage(atlas)
  UnloadImage(atlas)

  # SDF font generation from TTF font
  fontSDF = Font.new
  fontSDF.baseSize = 16
  fontSDF.glyphCount = 95
  # Parameters > font size: 16, no glyphs array provided (0), glyphs count: 0 (defaults to 95)
  fontSDF.glyphs = LoadFontData(fileData, fileSize.read_int, 16, nil, 0, FONT_SDF)
  # Parameters > glyphs count: 95, font size: 16, glyphs padding in image: 0 px, pack method: 1 (Skyline algorythm)
  fontSDF_recs_buf = FFI::MemoryPointer.new(:pointer, 1)
  atlas = GenImageFontAtlas(fontSDF.glyphs, fontSDF_recs_buf, 95, 16, 0, 1)
  fontSDF.recs = fontSDF_recs_buf.read_pointer
  fontSDF.texture = LoadTextureFromImage(atlas)
  UnloadImage(atlas)

  UnloadFileData(fileData) # Free memory from loaded file

  # Load SDF required shader (we use default vertex shader)
  shader = LoadShader(nil, "#{RAYLIB_TEXT_PATH}resources/shaders/glsl#{GLSL_VERSION}/sdf.fs")
  SetTextureFilter(fontSDF.texture, TEXTURE_FILTER_BILINEAR) # Required for SDF font

  fontPosition = Vector2.create(40, screenHeight/2.0 - 50)
  textSize = Vector2.create(0.0, 0.0)
  fontSize = 16.0
  currentFont = 0 # 0 - fontDefault, 1 - fontSDF

  SetTargetFPS(60)

  until WindowShouldClose()
    fontSize += GetMouseWheelMove() * 8.0

    fontSize = 6 if fontSize < 6

    currentFont = IsKeyDown(KEY_SPACE) ? 1 : 0

    if currentFont == 0
      textSize = MeasureTextEx(fontDefault, msg, fontSize, 0)
    else
      textSize = MeasureTextEx(fontSDF, msg, fontSize, 0)
    end

    fontPosition.x = GetScreenWidth()/2 - textSize.x/2
    fontPosition.y = GetScreenHeight()/2 - textSize.y/2 + 80

    BeginDrawing()

      ClearBackground(RAYWHITE)

      if currentFont == 1
        # NOTE: SDF fonts require a custom SDF shader to compute fragment color
        BeginShaderMode(shader)    # Activate SDF font shader
        DrawTextEx(fontSDF, msg, fontPosition, fontSize, 0, BLACK)
        EndShaderMode()            # Activate our default shader for next drawings

        DrawTexture(fontSDF.texture, 10, 10, BLACK)
      else
        DrawTextEx(fontDefault, msg, fontPosition, fontSize, 0, BLACK)
        DrawTexture(fontDefault.texture, 10, 10, BLACK)
      end

      if currentFont == 1
        DrawText("SDF!", 320, 20, 80, RED)
      else
        DrawText("default font", 315, 40, 30, GRAY)
      end

      DrawText("FONT SIZE: 16.0", GetScreenWidth() - 240, 20, 20, DARKGRAY)
      DrawText(TextFormat("RENDER SIZE: %02.02f", :float, fontSize), GetScreenWidth() - 240, 50, 20, DARKGRAY)
      DrawText("Use MOUSE WHEEL to SCALE TEXT!", GetScreenWidth() - 240, 90, 10, DARKGRAY)

      DrawText("HOLD SPACE to USE SDF FONT VERSION!", 340, GetScreenHeight() - 30, 20, MAROON)
    EndDrawing()
  end

  UnloadFont(fontDefault)
  UnloadFont(fontSDF)
  UnloadShader(shader)

  CloseWindow()
end
