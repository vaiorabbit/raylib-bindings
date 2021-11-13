require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - drop files")

  count = 0
  droppedFiles = nil

  SetTargetFPS(60)

  until WindowShouldClose()

    if IsFileDropped()
      count_buf = FFI::MemoryPointer.new(:int, 1)
      droppedFiles = GetDroppedFiles(count_buf)
      count = count_buf.read(:int)
      droppedFiles = droppedFiles.read_array_of_pointer(count).map! {|filenamePtr| filenamePtr.read_string}
    end

    BeginDrawing()
    ClearBackground(RAYWHITE)

    if count == 0
      DrawText("Drop your files to this window!", 100, 40, 20, DARKGRAY)
    else
      DrawText("Dropped files:", 100, 40, 20, DARKGRAY)

      count.times do |i|
        if i % 2 == 0
          DrawRectangle(0, 85 + 40*i, screenWidth, 40, Fade(LIGHTGRAY, 0.5))
        else
          DrawRectangle(0, 85 + 40*i, screenWidth, 40, Fade(LIGHTGRAY, 0.3))
        end
        DrawText(droppedFiles[i], 120, 100 + 40*i, 10, GRAY)
      end
      DrawText("Drop new files...", 100, 110 + 40*count, 20, DARKGRAY)
    end

    EndDrawing()
  end

  ClearDroppedFiles()
  CloseWindow()
end
