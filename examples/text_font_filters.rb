# coding: utf-8
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - font filters")

  msg = "Loaded Font"

  # NOTE: Textures/Fonts MUST be loaded after Window initialization (OpenGL context is required)

  # TTF Font loading with custom generation parameters
  font = LoadFontEx(RAYLIB_TEXT_PATH + "resources/KAISG.ttf", 96, nil, 0)

  # Generate mipmap levels to use trilinear filtering
  # NOTE: On 2D drawing it won't be noticeable, it looks like FILTER_BILINEAR
  GenTextureMipmaps(font[:texture].pointer)

  fontSize = font[:baseSize].to_f
  fontPosition = Vector2.create(40.0, screenHeight/2.0 - 80.0)
  textSize = Vector2.create(0.0, 0.0)

  # Setup texture scaling filter
  SetTextureFilter(font[:texture], TEXTURE_FILTER_POINT)
  currentFontFilter = 0 # TEXTURE_FILTER_POINT

  SetTargetFPS(60)

  until WindowShouldClose()

    fontSize += GetMouseWheelMove() * 4.0

    # Choose font texture filter method
    if IsKeyPressed(KEY_ONE)
      SetTextureFilter(font[:texture], TEXTURE_FILTER_POINT)
      currentFontFilter = 0
    elsif IsKeyPressed(KEY_TWO)
      SetTextureFilter(font[:texture], TEXTURE_FILTER_BILINEAR)
      currentFontFilter = 1
    elsif IsKeyPressed(KEY_THREE)
      # NOTE: Trilinear filter won't be noticed on 2D drawing
      SetTextureFilter(font[:texture], TEXTURE_FILTER_TRILINEAR)
      currentFontFilter = 2
    end

    textSize = MeasureTextEx(font, msg, fontSize, 0)

    if IsKeyDown(KEY_LEFT)
      fontPosition[:x] -= 10
    elsif IsKeyDown(KEY_RIGHT)
      fontPosition[:x] += 10
    end

    # Load a dropped TTF file dynamically (at current fontSize)
    if IsFileDropped()
      count = FFI::MemoryPointer.new :int
      droppedFiles = LoadDroppedFiles(count)

      # NOTE: We only support first ttf file dropped
      file_path = droppedFiles.read_pointer.read_string
      if IsFileExtension(file_path, ".ttf")
        UnloadFont(font)
        font = LoadFontEx(file_path, fontSize.to_i, nil, 0)
        UnloadDroppedFiles()
      end
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)

      DrawText("Use mouse wheel to change font size", 20, 20, 10, GRAY)
      DrawText("Use KEY_RIGHT and KEY_LEFT to move text", 20, 40, 10, GRAY)
      DrawText("Use 1, 2, 3 to change texture filter", 20, 60, 10, GRAY)
      DrawText("Drop a new TTF font for dynamic loading", 20, 80, 10, DARKGRAY)

      DrawTextEx(font, msg, fontPosition, fontSize, 0, BLACK)

      # TODO: It seems texSize measurement is not accurate due to chars offsets...
      #DrawRectangleLines(fontPosition.x, fontPosition.y, textSize.x, textSize.y, RED);

      DrawRectangle(0, screenHeight - 80, screenWidth, 80, LIGHTGRAY)
      DrawText(TextFormat("Font size: %02.02f", :float, fontSize), 20, screenHeight - 50, 10, DARKGRAY)
      DrawText(TextFormat("Text size: [%02.02f, %02.02f]", :float, textSize[:x], :float, textSize[:y]), 20, screenHeight - 30, 10, DARKGRAY)
      DrawText("CURRENT TEXTURE FILTER:", 250, 400, 20, GRAY)

      if currentFontFilter == 0
        DrawText("POINT", 570, 400, 20, BLACK)
      elsif currentFontFilter == 1
        DrawText("BILINEAR", 570, 400, 20, BLACK)
      elsif currentFontFilter == 2
        DrawText("TRILINEAR", 570, 400, 20, BLACK)
      end

    EndDrawing()
  end

  UnloadDroppedFiles()
  UnloadFont(font)
  CloseWindow()

end
