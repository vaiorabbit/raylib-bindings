require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  MAX_BUILDINGS = 100

  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - 2d camera")

  player = Rectangle.create(400, 280, 40, 40)
  buildings = Array.new(MAX_BUILDINGS) { Rectangle.create(0, 0, 0, 0) }
  buildColors = Array.new(MAX_BUILDINGS)

  spacing = 0

  MAX_BUILDINGS.times do |i|
    buildings[i][:width] = GetRandomValue(50, 200).to_f
    buildings[i][:height] = GetRandomValue(100, 800).to_f
    buildings[i][:y] = screenHeight - 130.0 - buildings[i][:height]
    buildings[i][:x] = -6000.0 + spacing

    spacing += buildings[i][:width].to_i

    buildColors[i] = Color.from_u8(GetRandomValue(200, 240), GetRandomValue(200, 240), GetRandomValue(200, 250), 255)
  end

  camera = Camera2D.new
  camera[:target] = Vector2.create(player[:x] + 20.0, player[:y] + 20.0)
  camera[:offset] = Vector2.create(screenWidth / 2.0, screenHeight / 2.0)
  camera[:rotation] = 0.0
  camera[:zoom] = 1.0

  SetTargetFPS(60)

  until WindowShouldClose()

    # Player movement
    if IsKeyDown(KEY_RIGHT)
      player[:x] += 2
    elsif IsKeyDown(KEY_LEFT)
      player[:x] -= 2
    end

    # Camera target follows player
    camera[:target][:x] = player[:x] + 20
    camera[:target][:y] = player[:y] + 20

    # Camera rotation controls
    if IsKeyDown(KEY_A)
      camera[:rotation] -= 1
    elsif IsKeyDown(KEY_S)
      camera[:rotation] += 1
    end

    # Limit camera rotation to 80 degrees (-40 to 40)
    camera[:rotation] = camera[:rotation].clamp(-40, 40)

    # Camera zoom controls
    camera[:zoom] += GetMouseWheelMove() * 0.05
    camera[:zoom] = camera[:zoom].clamp(0.1, 3.0)

    # Camera reset (zoom and rotation)
    camera[:zoom], camera[:rotation] = 1.0, 0.0 if IsKeyPressed(KEY_R)

    BeginDrawing()
      ClearBackground(RAYWHITE)

      BeginMode2D(camera)
        DrawRectangle(-6000, 320, 13000, 8000, DARKGRAY)

        MAX_BUILDINGS.times { |i| DrawRectangleRec(buildings[i], buildColors[i]) }

        DrawRectangleRec(player, RED)

        DrawLine(camera[:target][:x].to_i, -screenHeight*10, camera[:target][:x].to_i, screenHeight*10, GREEN)
        DrawLine(-screenWidth*10, camera[:target][:y].to_i, screenWidth*10, camera[:target][:y].to_i, GREEN)
      EndMode2D()

      DrawText("SCREEN AREA", 640, 10, 20, RED)

      DrawRectangle(0, 0, screenWidth, 5, RED)
      DrawRectangle(0, 5, 5, screenHeight - 10, RED)
      DrawRectangle(screenWidth - 5, 5, 5, screenHeight - 10, RED)
      DrawRectangle(0, screenHeight - 5, screenWidth, 5, RED)

      DrawRectangle(10, 10, 250, 113, Fade(SKYBLUE, 0.5))
      DrawRectangleLines(10, 10, 250, 113, BLUE)

      DrawText("Free 2d camera controls:", 20, 20, 10, BLACK)
      DrawText("- Right/Left to move Offset", 40, 40, 10, DARKGRAY)
      DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY)
      DrawText("- A / S to Rotate", 40, 80, 10, DARKGRAY)
      DrawText("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY)

    EndDrawing()
  end

  CloseWindow()
end
