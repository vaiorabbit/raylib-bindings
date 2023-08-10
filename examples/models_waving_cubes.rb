require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - waving cubes")

  # Initialize the camera
  camera = Camera.new
             .with_position(30.0, 20.0, 30.0)
             .with_target(0.0, 0.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(70.0)
             .with_projection(CAMERA_PERSPECTIVE)

  # Specify the amount of blocks in each direction
  numBlocks = 15

  SetTargetFPS(60)

  until WindowShouldClose()
    time = GetTime()

    # Calculate time scale for cube position and size
    scale = (2.0 + Math.sin(time)) * 0.7

    # Move camera around the scene
    cameraTime = time * 0.3
    camera.position.x = Math.cos(cameraTime) * 40.0
    camera.position.z = Math.sin(cameraTime) * 40.0

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawGrid(10, 5.0)
        numBlocks.times do |x|
          numBlocks.times do |y|
            numBlocks.times do |z|
              # Scale of the blocks depends on x/y/z positions
              blockScale = (x + y + z) / 30.0

              # Scatter makes the waving effect by adding blockScale over time
              scatter = Math.sin(blockScale*20.0 + (time*4.0))

              # Calculate the cube position
              cubePos = Vector3.create(
                (x.to_f - numBlocks/2)*(scale*3.0) + scatter,
                (y.to_f - numBlocks/2)*(scale*2.0) + scatter,
                (z.to_f - numBlocks/2)*(scale*3.0) + scatter)

              # Pick a color with a hue depending on cube position for the rainbow color effect
              cubeColor = ColorFromHSV((((x + y + z)*18)%360), 0.75, 0.9)

              # Calculate cube size
              cubeSize = (2.4 - scale)*blockScale

              # And finally, draw the cube!
              DrawCube(cubePos, cubeSize, cubeSize, cubeSize, cubeColor)
            end
          end
        end
      EndMode3D()
      DrawFPS(10, 10)
    EndDrawing()
  end

  CloseWindow()
end
