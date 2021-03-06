require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - geometric shapes")

  # Initialize the camera
  camera = Camera.new
  camera[:position] = Vector3.create(0.0, 10.0, 10.0)
  camera[:target] = Vector3.create(0.0, 0.0, 0.0)
  camera[:up] = Vector3.create(0.0, 1.0, 0.0)
  camera[:fovy] = 45.0

  SetTargetFPS(60)

  until WindowShouldClose()

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawCube(Vector3.create(-4.0, 0.0, 2.0), 2.0, 5.0, 2.0, RED)
        DrawCubeWires(Vector3.create(-4.0, 0.0, 2.0), 2.0, 5.0, 2.0, GOLD)
        DrawCubeWires(Vector3.create(-4.0, 0.0, -2.0), 3.0, 6.0, 2.0, MAROON)

        DrawSphere(Vector3.create(-1.0, 0.0, -2.0), 1.0, GREEN)
        DrawSphereWires(Vector3.create(1.0, 0.0, 2.0), 2.0, 16, 16, LIME)

        DrawCylinder(Vector3.create(4.0, 0.0, -2.0), 1.0, 2.0, 3.0, 4, SKYBLUE)
        DrawCylinderWires(Vector3.create(4.0, 0.0, -2.0), 1.0, 2.0, 3.0, 4, DARKBLUE)
        DrawCylinderWires(Vector3.create(4.5, -1.0, 2.0), 1.0, 1.0, 2.0, 6, BROWN)

        DrawCylinder(Vector3.create(1.0, 0.0, -4.0), 0.0, 1.5, 3.0, 8, GOLD)
        DrawCylinderWires(Vector3.create(1.0, 0.0, -4.0), 0.0, 1.5, 3.0, 8, PINK)

        DrawGrid(10, 1.0) # Draw a grid
      EndMode3D()
      DrawFPS(10, 10)
    EndDrawing()

  end

  CloseWindow()
end
