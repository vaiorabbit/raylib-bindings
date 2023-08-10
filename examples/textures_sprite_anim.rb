require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  MAX_FRAME_SPEED = 15
  MIN_FRAME_SPEED = 1

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - sprite anim")

  # NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
  scarfy = LoadTexture(RAYLIB_TEXTURE_PATH + "resources/scarfy.png")

  position = Vector2.create(350.0, 280.0)
  frameRec = Rectangle.create(0.0, 0.0, scarfy.width.to_f/6, scarfy.height.to_f)
  currentFrame = 0

  framesCounter = 0
  framesSpeed = 8 # Number of spritesheet frames shown by second

  SetTargetFPS(60)

  until WindowShouldClose()

    framesCounter += 1

    if framesCounter >= (60/framesSpeed)
      framesCounter = 0
      currentFrame += 1

      currentFrame = 0 if currentFrame > 5

      frameRec.x = currentFrame.to_f * scarfy.width.to_f / 6
    end

    # Control frames speed
    if IsKeyPressed(KEY_RIGHT)
      framesSpeed += 1
    elsif IsKeyPressed(KEY_LEFT)
      framesSpeed -= 1
    end

    if framesSpeed > MAX_FRAME_SPEED
      framesSpeed = MAX_FRAME_SPEED
    elsif framesSpeed < MIN_FRAME_SPEED
      framesSpeed = MIN_FRAME_SPEED
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)

      DrawTexture(scarfy, 15, 40, WHITE)
      DrawRectangleLines(15, 40, scarfy.width, scarfy.height, LIME)
      DrawRectangleLines(15 + frameRec.x.to_i, 40 + frameRec.y.to_i, frameRec.width.to_i, frameRec.height.to_i, RED)

      DrawText("FRAME SPEED: ", 165, 210, 10, DARKGRAY)
      DrawText(TextFormat("%02i FPS", :int, framesSpeed), 575, 210, 10, DARKGRAY)
      DrawText("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 240, 10, DARKGRAY)

      MAX_FRAME_SPEED.times do |i|
        DrawRectangle(250 + 21*i, 205, 20, 20, RED) if i < framesSpeed
        DrawRectangleLines(250 + 21*i, 205, 20, 20, MAROON)
      end

      DrawTextureRec(scarfy, frameRec, position, WHITE) # Draw part of the texture
      DrawText("(c) Scarfy sprite by Eiden Marsal", screenWidth - 200, screenHeight - 20, 10, GRAY)

    EndDrawing()
  end

  UnloadTexture(scarfy)
  CloseWindow()

end
