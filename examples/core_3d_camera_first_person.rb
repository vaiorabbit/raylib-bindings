require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  MAX_COLUMNS = 20

  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - 3d camera first person")

  # Define the camera to look into our 3d world (position, target, up vector)
  camera = Camera.new
  camera.position.set(4.0, 2.0, 4.0)
  camera.target.set(0.0, 1.8, 0.0)
  camera.up.set(0.0, 1.0, 0.0)
  camera.fovy = 60.0
  camera.projection = CAMERA_PERSPECTIVE

  # Generates some random columns
  heights = []
  positions = []
  colors = []

  MAX_COLUMNS.times do |i|
    heights << GetRandomValue(1, 12)
    positions << Vector3.create(GetRandomValue(-15, 15).to_f, heights[i]/2.0, GetRandomValue(-15, 15).to_f)
    colors << Color.from_u8(GetRandomValue(20, 255), GetRandomValue(10, 55), 30, 255)
  end

  SetTargetFPS(60) # Set our game to run at 60 frames-per-second

  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_FIRST_PERSON)
    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawPlane(Vector3.create(0.0, 0.0, 0.0), Vector2.create(32.0, 32.0), LIGHTGRAY) # Draw ground
        DrawCube(Vector3.create(-16.0, 2.5, 0.0), 1.0, 5.0, 32.0, BLUE)                 # Draw a blue wall
        DrawCube(Vector3.create(16.0, 2.5, 0.0), 1.0, 5.0, 32.0, LIME)                  # Draw a green wall
        DrawCube(Vector3.create(0.0, 2.5, 16.0), 32.0, 5.0, 1.0, GOLD)                  # Draw a yellow wall
        # Draw some cubes around
        MAX_COLUMNS.times do |i|
          DrawCube(positions[i], 2.0, heights[i], 2.0, colors[i])
          DrawCubeWires(positions[i], 2.0, heights[i], 2.0, MAROON)
        end
      EndMode3D()

      DrawRectangle( 10, 10, 220, 70, Fade(SKYBLUE, 0.5))
      DrawRectangleLines( 10, 10, 220, 70, BLUE)

      DrawText("First person camera default controls:", 20, 20, 10, BLACK)
      DrawText("- Move with keys: W, A, S, D", 40, 40, 10, DARKGRAY)
      DrawText("- Mouse move to look around", 40, 60, 10, DARKGRAY)
    EndDrawing()
  end

  CloseWindow()
end
