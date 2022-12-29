require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - box collisions")

  # Initialize the camera
  camera = Camera.new
  camera.position.set(0.0, 10.0, 10.0)
  camera.target.set(0.0, 0.0, 0.0)
  camera.up.set(0.0, 1.0, 0.0)
  camera.fovy = 45.0

  playerPosition = Vector3.create(0.0, 1.0, 2.0)
  playerSize = Vector3.create(1.0, 2.0, 1.0)
  playerColor = GREEN

  enemyBoxPos = Vector3.create(-4.0, 1.0, 0.0)
  enemyBoxSize = Vector3.create(2.0, 2.0, 2.0)

  enemySpherePos = Vector3.create(4.0, 0.0, 0.0)
  enemySphereSize = 1.5

  collision = false

  SetTargetFPS(60)

  until WindowShouldClose()

    # Move player
    if IsKeyDown(KEY_RIGHT)
      playerPosition.x += 0.2
    elsif IsKeyDown(KEY_LEFT)
      playerPosition.x -= 0.2
    elsif IsKeyDown(KEY_DOWN)
      playerPosition.z += 0.2
    elsif IsKeyDown(KEY_UP)
      playerPosition.z -= 0.2
    end

    collision = false

    playerBox = BoundingBox.create(playerPosition.x - playerSize.x/2,
                                   playerPosition.y - playerSize.y/2,
                                   playerPosition.z - playerSize.z/2,
                                   playerPosition.x + playerSize.x/2,
                                   playerPosition.y + playerSize.y/2,
                                   playerPosition.z + playerSize.z/2)

    enemyBox = BoundingBox.create(enemyBoxPos.x - enemyBoxSize.x/2,
                                  enemyBoxPos.y - enemyBoxSize.y/2,
                                  enemyBoxPos.z - enemyBoxSize.z/2,
                                  enemyBoxPos.x + enemyBoxSize.x/2,
                                  enemyBoxPos.y + enemyBoxSize.y/2,
                                  enemyBoxPos.z + enemyBoxSize.z/2)

    # Check collisions player vs enemy-box
    collision = true if CheckCollisionBoxes(playerBox, enemyBox)

    # Check collisions player vs enemy-sphere
    collision = true if CheckCollisionBoxSphere(playerBox, enemySpherePos, enemySphereSize)

    playerColor = collision ? RED : GREEN

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        # Draw enemy-box
        DrawCube(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, GRAY)
        DrawCubeWires(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, DARKGRAY)

        # Draw enemy-sphere
        DrawSphere(enemySpherePos, enemySphereSize, GRAY)
        DrawSphereWires(enemySpherePos, enemySphereSize, 16, 16, DARKGRAY)

        # Draw player
        DrawCubeV(playerPosition, playerSize, playerColor)

        DrawGrid(10, 1.0)
      EndMode3D()

      DrawText("Move player with cursors to collide", 220, 40, 20, GRAY)

      DrawFPS(10, 10)
    EndDrawing()
  end

  CloseWindow()
end
