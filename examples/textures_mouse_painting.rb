# coding: utf-8
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - mouse painting")

  # Colours to choose from
  colors = [
    RAYWHITE, YELLOW, GOLD, ORANGE, PINK, RED, MAROON, GREEN, LIME, DARKGREEN,
    SKYBLUE, BLUE, DARKBLUE, PURPLE, VIOLET, DARKPURPLE, BEIGE, BROWN, DARKBROWN,
    LIGHTGRAY, GRAY, DARKGRAY, BLACK
  ]
  MAX_COLORS_COUNT = colors.length

  # Define colorsRecs data (for every rectangle)
  colorsRecs = []
  MAX_COLORS_COUNT.times do |i|
    colorsRecs << Rectangle.create(10 + 30.0*i + 2*i, 10, 30, 30)
  end

  colorSelected = 0
  colorSelectedPrev = colorSelected
  colorMouseHover = 0
  brushSize = 20.0
  mouseWasPressed = false

  btnSaveRec = Rectangle.create(750, 10, 40, 30)
  btnSaveMouseHover = false
  showSaveMessage = false
  saveMessageCounter = 0

  # Create a RenderTexture2D to use as a canvas
  target = LoadRenderTexture(screenWidth, screenHeight)

  # Clear render texture before entering the game loop
  BeginTextureMode(target)
  ClearBackground(colors[0])
  EndTextureMode()

  SetTargetFPS(120) # Set our game to run at 120 frames-per-second

  until WindowShouldClose()

    mousePos = GetMousePosition()

    # Move between colors with keys
    if IsKeyPressed(KEY_RIGHT)
      colorSelected += 1
    elsif IsKeyPressed(KEY_LEFT)
      colorSelected -= 1
    end

    if colorSelected >= MAX_COLORS_COUNT
      colorSelected = MAX_COLORS_COUNT - 1
    elsif colorSelected < 0
      colorSelected = 0
    end

    # Choose color with mouse
    MAX_COLORS_COUNT.times do |i|
      if CheckCollisionPointRec(mousePos, colorsRecs[i])
        colorMouseHover = i
        break
      else
        colorMouseHover = -1
      end
    end

    if (colorMouseHover >= 0) && IsMouseButtonPressed(MOUSE_BUTTON_LEFT)
      colorSelected = colorMouseHover
      colorSelectedPrev = colorSelected
    end

    # Change brush size
    brushSize += GetMouseWheelMove() * 5
    brushSize = 2 if brushSize < 2
    brushSize = 50 if brushSize > 50

    if IsKeyPressed(KEY_C)
      # Clear render texture to clear color
      BeginTextureMode(target)
      ClearBackground(colors[0])
      EndTextureMode()
    end

    if IsMouseButtonDown(MOUSE_BUTTON_LEFT) || (GetGestureDetected() == GESTURE_DRAG)
      # Paint circle into render texture
      # NOTE: To avoid discontinuous circles, we could store
      # previous-next mouse points and just draw a line using brush size
      BeginTextureMode(target)
      DrawCircle(mousePos.x.to_i, mousePos.y.to_i, brushSize, colors[colorSelected]) if mousePos.y > 50
      EndTextureMode()
    end

    if IsMouseButtonDown(MOUSE_BUTTON_RIGHT)
      if !mouseWasPressed
        colorSelectedPrev = colorSelected
        colorSelected = 0
      end

      mouseWasPressed = true

      # Erase circle from render texture
      BeginTextureMode(target)
      DrawCircle(mousePos.x.to_i, mousePos.y.to_i, brushSize, colors[0]) if mousePos.y > 50
      EndTextureMode()
    elsif IsMouseButtonReleased(MOUSE_BUTTON_RIGHT) && mouseWasPressed
      colorSelected = colorSelectedPrev
      mouseWasPressed = false
    end

    # Check mouse hover save button
    btnSaveMouseHover = CheckCollisionPointRec(mousePos, btnSaveRec)

    # Image saving logic
    # NOTE: Saving painted texture to a default named image
    if (btnSaveMouseHover && IsMouseButtonReleased(MOUSE_BUTTON_LEFT)) || IsKeyPressed(KEY_S)
      image = LoadImageFromTexture(target.texture)
      ImageFlipVertical(image.pointer)
      ExportImage(image, "my_amazing_texture_painting.png")
      UnloadImage(image)
      showSaveMessage = true
    end

    if showSaveMessage
      # On saving, show a full screen message for 2 seconds
      saveMessageCounter += 1
      if saveMessageCounter > 240
        showSaveMessage = false
        saveMessageCounter = 0
      end
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)

      # NOTE: Render texture must be y-flipped due to default OpenGL coordinates (left-bottom)
      DrawTextureRec(target.texture, Rectangle.create(0, 0, target.texture.width.to_f, -target.texture.height.to_f), Vector2.create(0, 0), WHITE)

      # Draw drawing circle for reference
      if mousePos.y > 50
        if IsMouseButtonDown(MOUSE_BUTTON_RIGHT)
          DrawCircleLines(mousePos.x.to_i, mousePos.y.to_i, brushSize, GRAY)
        else
          DrawCircle(GetMouseX(), GetMouseY(), brushSize, colors[colorSelected])
        end
      end

      # Draw top panel
      DrawRectangle(0, 0, GetScreenWidth(), 50, RAYWHITE)
      DrawLine(0, 50, GetScreenWidth(), 50, LIGHTGRAY)

      # Draw color selection rectangles
      MAX_COLORS_COUNT.times do |i|
        DrawRectangleRec(colorsRecs[i], colors[i])
      end
      DrawRectangleLines(10, 10, 30, 30, LIGHTGRAY)

      DrawRectangleRec(colorsRecs[colorMouseHover], Fade(WHITE, 0.6)) if colorMouseHover >= 0

      DrawRectangleLinesEx(Rectangle.create(colorsRecs[colorSelected].x - 2, colorsRecs[colorSelected].y - 2,
                                            colorsRecs[colorSelected].width + 4, colorsRecs[colorSelected].height + 4),
                           2, BLACK)

      # Draw save image button
      DrawRectangleLinesEx(btnSaveRec, 2, btnSaveMouseHover ? RED : BLACK)
      DrawText("SAVE!", 755, 20, 10, btnSaveMouseHover ? RED : BLACK)

      # Draw save image message
      if showSaveMessage
        DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(RAYWHITE, 0.8))
        DrawRectangle(0, 150, GetScreenWidth(), 80, BLACK)
        DrawText("IMAGE SAVED:  my_amazing_texture_painting.png", 150, 180, 20, RAYWHITE)
      end

    EndDrawing()
  end

  UnloadRenderTexture(target)
  CloseWindow()

end
