require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - music playing (streaming)")

  InitAudioDevice()

  music = LoadMusicStream(RAYLIB_AUDIO_PATH + "resources/country.mp3")

  PlayMusicStream(music)

  timePlayed = 0.0
  pause = false

  SetTargetFPS(60)

  until WindowShouldClose()

    UpdateMusicStream(music) # Update music buffer with new stream data

    # Restart music playing (stop and play)
    if IsKeyPressed(KEY_SPACE)
      StopMusicStream(music)
      PlayMusicStream(music)
    end

    # Pause/Resume music playing
    if IsKeyPressed(KEY_P)
      pause = !pause
      if pause
        PauseMusicStream(music)
      else
        ResumeMusicStream(music)
      end
    end

    # Get timePlayed scaled to bar dimensions (400 pixels)
    timePlayed = GetMusicTimePlayed(music) / GetMusicTimeLength(music) * 400
    StopMusicStream(music) if timePlayed > 400

    BeginDrawing()
      ClearBackground(RAYWHITE)
      DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, LIGHTGRAY)

      DrawRectangle(200, 200, 400, 12, LIGHTGRAY)
      DrawRectangle(200, 200, timePlayed.to_i, 12, MAROON)
      DrawRectangleLines(200, 200, 400, 12, GRAY)

      DrawText("PRESS SPACE TO RESTART MUSIC", 215, 250, 20, LIGHTGRAY)
      DrawText("PRESS P TO PAUSE/RESUME MUSIC", 208, 280, 20, LIGHTGRAY)
    EndDrawing()
  end

  UnloadMusicStream(music)
  CloseAudioDevice()
  CloseWindow()
end
