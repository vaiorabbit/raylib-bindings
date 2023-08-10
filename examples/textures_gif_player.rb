require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  MAX_FRAME_DELAY = 20
  MIN_FRAME_DELAY = 1

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - gif playing")

  animFrames_buf = FFI::MemoryPointer.new(:int, 1)

  # Load all GIF animation frames into a single Image
  # NOTE: GIF data is always loaded as RGBA (32bit) by default
  # NOTE: Frames are just appended one after another in image.data memory
  imScarfyAnim = LoadImageAnim(RAYLIB_TEXTURE_PATH + "resources/scarfy_run.gif", animFrames_buf)

  animFrames = animFrames_buf.read_int

  # Load texture from image
  # NOTE: We will update this texture when required with next frame data
  # WARNING: It's not recommended to use this technique for sprites animation,
  # use spritesheets instead, like illustrated in textures_sprite_anim example
  texScarfyAnim = LoadTextureFromImage(imScarfyAnim)

  nextFrameDataOffset = 0 # Current byte offset to next frame in image.data

  currentAnimFrame = 0 # Current animation frame to load and draw
  frameDelay = 8       # Frame delay to switch between animation frames
  frameCounter = 0     # General frames counter

  SetTargetFPS(60)

  until WindowShouldClose()

    frameCounter += 1

    if frameCounter >= frameDelay
      # Move to next frame
      # NOTE: If final frame is reached we return to first frame
      currentAnimFrame += 1
      currentAnimFrame = 0 if currentAnimFrame >= animFrames

      # Get memory offset position for next frame data in image.data
      nextFrameDataOffset = imScarfyAnim.width * imScarfyAnim.height * 4 * currentAnimFrame

      # Update GPU texture data with next frame image data
      # WARNING: Data size (frame size) and pixel format must match already created texture
      UpdateTexture(texScarfyAnim, imScarfyAnim.data + nextFrameDataOffset)

      frameCounter = 0
    end

    # Control frames delay
    if IsKeyPressed(KEY_RIGHT)
      frameDelay += 1
    elsif IsKeyPressed(KEY_LEFT)
      frameDelay -= 1
    end

    if frameDelay > MAX_FRAME_DELAY
      frameDelay = MAX_FRAME_DELAY
    elsif frameDelay < MIN_FRAME_DELAY
      frameDelay = MIN_FRAME_DELAY
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)

      DrawText(TextFormat("TOTAL GIF FRAMES:  %02i", :int, animFrames), 50, 30, 20, LIGHTGRAY)
      DrawText(TextFormat("CURRENT FRAME: %02i", :int, currentAnimFrame), 50, 60, 20, GRAY)
      DrawText(TextFormat("CURRENT FRAME IMAGE.DATA OFFSET: %02i", :int, nextFrameDataOffset), 50, 90, 20, GRAY)

      DrawText("FRAME DELAY: ", 100, 305, 10, DARKGRAY)
      DrawText(TextFormat("%02i FPS", :int, frameDelay), 575, 210, 10, DARKGRAY)
      DrawText("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 240, 10, DARKGRAY)

      MAX_FRAME_DELAY.times do |i|
        DrawRectangle(190 + 21*i, 300, 20, 20, RED) if i < frameDelay
        DrawRectangleLines(190 + 21*i, 300, 20, 20, MAROON)
      end

      DrawTexture(texScarfyAnim, GetScreenWidth() / 2 - texScarfyAnim.width / 2, 140, WHITE)
      DrawText("(c) Scarfy sprite by Eiden Marsal", screenWidth - 200, screenHeight - 20, 10, GRAY)

    EndDrawing()
  end

  UnloadTexture(texScarfyAnim)
  UnloadImage(imScarfyAnim)

  CloseWindow()

end
