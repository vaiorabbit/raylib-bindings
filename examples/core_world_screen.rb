require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  MAX_COLUMNS = 20

  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - 3d camera free")

  # Define the camera to look into our 3d world
  camera = Camera.new
             .with_position(10.0, 10.0, 10.0)
             .with_target(0.0, 0.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  cubePosition = Vector3.create(0.0, 0.0, 0.0)
  cubeScreenPosition = Vector2.create(0.0, 0.0)

  SetTargetFPS(60)

  speed = 0.25 # [Ruby raylib]

  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_CUSTOM)
=begin
    # [Ruby raylib] Move cube position
    move = Vector3.create(0, 0, 0) # [Ruby raylib]
    move.x += speed if IsKeyDown(KEY_RIGHT)
    move.x -= speed if IsKeyDown(KEY_LEFT)
    move.z += speed if IsKeyDown(KEY_DOWN)
    move.z -= speed if IsKeyDown(KEY_UP)

    to_camera = Vector3Normalize(Vector3.create(camera.position.x, 0, camera.position.z))
    rotate_y = QuaternionFromVector3ToVector3(Vector3.create(0, 0, 1), to_camera)
    move = Vector3RotateByQuaternion(move, rotate_y)

    cubePosition = Vector3Add(cubePosition, move)
=end
    # Calculate cube screen space position (with a little offset to be in top)
    cubeScreenPosition = GetWorldToScreen(Vector3.create(cubePosition.x, cubePosition.y + 2.5, cubePosition.z), camera)

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawCube(cubePosition, 2.0, 2.0, 2.0, RED)
        DrawCubeWires(cubePosition, 2.0, 2.0, 2.0, MAROON)
        DrawGrid(10, 1.0)
      EndMode3D()

      DrawText("Enemy: 100 / 100", cubeScreenPosition.x - MeasureText("Enemy: 100/100", 20)/2, cubeScreenPosition.y, 20, BLACK)
      DrawText("Text is always on top of the cube", (screenWidth - MeasureText("Text is always on top of the cube", 20))/2, 25, 20, GRAY)
    EndDrawing()
  end

  CloseWindow()
end
