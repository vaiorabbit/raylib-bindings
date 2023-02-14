require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - heightmap loading and drawing")

  camera = Camera.new
  camera[:position] = Vector3.create(18.0, 18.0, 18.0)
  camera[:target] = Vector3.create(0.0, 0.0, 0.0)
  camera[:up] = Vector3.create(0.0, 1.0, 0.0)
  camera[:fovy] = 45.0
  camera[:projection] = CAMERA_PERSPECTIVE

  image = LoadImage(RAYLIB_MODELS_PATH + "resources/heightmap.png") # Load heightmap image (RAM)
  texture = LoadTextureFromImage(image)                             # Convert image to texture (VRAM)

  mesh = GenMeshHeightmap(image, Vector3.create(16.0, 8.0, 16.0))   # Generate heightmap mesh (RAM and VRAM)
  model = LoadModelFromMesh(mesh)                                   # Load model from generated mesh

  SetMaterialTexture(model.material(0), MATERIAL_MAP_ALBEDO, texture) # Set map diffuse texture
  mapPosition = Vector3.create(-8.0, 0.0, -8.0)                        # Set model position

  UnloadImage(image)                    # Unload heightmap image from RAM, already uploaded to VRAM

  SetCameraMode(camera, CAMERA_ORBITAL) # Set an orbital camera mode

  SetTargetFPS(60)                      # Set our game to run at 60 frames-per-second

  until WindowShouldClose()
    UpdateCamera(camera.pointer)

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawModel(model, mapPosition, 1.0, RED)
      EndMode3D()

      DrawTexture(texture, screenWidth - texture[:width] - 20, 20.0, WHITE)
      DrawRectangleLines(screenWidth - texture[:width] - 20, 20, texture[:width], texture[:height], GREEN)

      DrawFPS(10, 10)
    EndDrawing()
  end

  UnloadTexture(texture) # Unload texture
  UnloadModel(model)     # Unload model

  CloseWindow()
end
