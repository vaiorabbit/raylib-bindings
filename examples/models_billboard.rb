require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - drawing billboards")

  # Define the camera to look into our 3d world
  camera = Camera.new
             .with_position(5.0, 4.0, 5.0)
             .with_target(0.0, 2.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  bill = LoadTexture(RAYLIB_MODELS_PATH + "resources/billboard.png") # Our texture billboard
  billPosition = Vector3.create(0.0, 2.0, 0.0)                       # Position where draw billboard

  SetTargetFPS(60)

  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawGrid(10, 1.0)
        DrawBillboard(camera, bill, billPosition, 2.0, WHITE)
      EndMode3D()

      DrawFPS(10, 10)
    EndDrawing()
  end

  UnloadTexture(bill)

  CloseWindow()
end
