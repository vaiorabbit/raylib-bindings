require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME

  # NOTE: Storage positions must start with 0, directly related to file memory layout
  STORAGE_POSITION_SCORE      = 0
  STORAGE_POSITION_HISCORE    = 1

  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - storage save/load values")

  score = 0
  hiscore = 0
  framesCounter = 0

  SetTargetFPS(60)

  until WindowShouldClose()

    if IsKeyPressed(KEY_R)
      score = GetRandomValue(1000, 2000)
      hiscore = GetRandomValue(2000, 4000)
    end

    if IsKeyPressed(KEY_ENTER)
      SaveStorageValue(STORAGE_POSITION_SCORE, score)
      SaveStorageValue(STORAGE_POSITION_HISCORE, hiscore)
    elsif (IsKeyPressed(KEY_SPACE))
      # NOTE: If requested position could not be found, value 0 is returned
      score = LoadStorageValue(STORAGE_POSITION_SCORE)
      hiscore = LoadStorageValue(STORAGE_POSITION_HISCORE)
    end

    framesCounter += 1

    BeginDrawing()
      ClearBackground(RAYWHITE)

      DrawText(TextFormat("SCORE: %i", :int, score), 280, 130, 40, MAROON)
      DrawText(TextFormat("HI-SCORE: %i", :int, hiscore), 210, 200, 50, BLACK)

      DrawText(TextFormat("frames: %i", :int, framesCounter), 10, 10, 20, LIME)

      DrawText("Press R to generate random numbers", 220, 40, 20, LIGHTGRAY)
      DrawText("Press ENTER to SAVE values", 250, 310, 20, LIGHTGRAY)
      DrawText("Press SPACE to LOAD values", 252, 350, 20, LIGHTGRAY)

    EndDrawing()
  end

  CloseWindow()
end
