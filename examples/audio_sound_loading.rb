require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - sound loading and playing")

  InitAudioDevice()

  fxWav = LoadSound(RAYLIB_AUDIO_PATH + "resources/sound.wav")
  fxOgg = LoadSound(RAYLIB_AUDIO_PATH + "resources/target.ogg")

  SetTargetFPS(60)

  until WindowShouldClose()

    PlaySound(fxWav) if IsKeyPressed(KEY_SPACE)
    PlaySound(fxOgg) if IsKeyPressed(KEY_ENTER)

    BeginDrawing()

      ClearBackground(RAYWHITE)

      DrawText("Press SPACE to PLAY the WAV sound!", 200, 180, 20, LIGHTGRAY)
      DrawText("Press ENTER to PLAY the OGG sound!", 200, 220, 20, LIGHTGRAY)

    EndDrawing()
  end

  UnloadSound(fxWav)
  UnloadSound(fxOgg)
  CloseAudioDevice()
  CloseWindow()
end
