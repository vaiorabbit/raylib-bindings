require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - basic shapes drawing")
  SetTargetFPS(60)

  raywhite = Color.new
  raywhite[:r] = 245; raywhite[:g] = 245; raywhite[:b] = 245; raywhite[:a] = 255

  darkgray = Color.new
  darkgray[:r] = 80; darkgray[:g] = 80; darkgray[:b] = 80; darkgray[:a] = 255;

  skyblue = Color.new
  skyblue[:r] = 102; skyblue[:g] = 191; skyblue[:b] = 255; skyblue[:a] = 255;

  darkblue = Color.new
  darkblue[:r] = 0; darkblue[:g] = 82; darkblue[:b] = 172; darkblue[:a] = 255;

  green = Color.new
  green[:r] = 0; green[:g] = 228; green[:b] = 48; green[:a] = 255;

  until WindowShouldClose()
    BeginDrawing()
    ClearBackground(raywhite)
    DrawText("some basic shapes available on raylib", 20, 20, 20, darkgray)

    # Circle shapes and lines
    DrawCircle(screenWidth/5, 120, 35, skyblue)
    DrawCircleGradient(screenWidth/5, 220, 60, green, skyblue)
    DrawCircleLines(screenWidth/5, 340, 80, darkblue)

    EndDrawing()
  end

  CloseWindow()
end
