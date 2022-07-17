require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - drop files")

  count = 0
  droppedFiles = FilePathList.new

  SetTargetFPS(60)

  until WindowShouldClose()

    if IsFileDropped()
      # Is some files have been previously loaded, unload them
      UnloadDroppedFiles(droppedFiles) if droppedFiles[:count] > 0

      # Load new dropped files
      droppedFiles = LoadDroppedFiles()
    end

    BeginDrawing()
    ClearBackground(RAYWHITE)

    if droppedFiles[:count] == 0
      DrawText("Drop your files to this window!", 100, 40, 20, DARKGRAY)
    else
      DrawText("Dropped files:", 100, 40, 20, DARKGRAY)

      droppedFiles[:count].times do |i|
        if i % 2 == 0
          DrawRectangle(0, 85 + 40*i, screenWidth, 40, Fade(LIGHTGRAY, 0.5))
        else
          DrawRectangle(0, 85 + 40*i, screenWidth, 40, Fade(LIGHTGRAY, 0.3))
        end
        path_ptr = (droppedFiles[:paths] + i * FFI::NativeType::POINTER.size).read_pointer
        DrawText(path_ptr.read_string, 120, 100 + 40*i, 10, GRAY)
      end
      DrawText("Drop new files...", 100, 110 + 40*droppedFiles[:count], 20, DARKGRAY)
    end

    EndDrawing()
  end

  UnloadDroppedFiles(droppedFiles)
  CloseWindow()
end
