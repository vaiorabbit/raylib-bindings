require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - heightmap loading and drawing")

  camera = Camera.new
             .with_position(18.0, 18.0, 18.0)
             .with_target(0.0, 0.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  image = LoadImage(RAYLIB_MODELS_PATH + "resources/heightmap.png") # Load heightmap image (RAM)
  texture = LoadTextureFromImage(image)                             # Convert image to texture (VRAM)

  mesh = GenMeshHeightmap(image, Vector3.create(16.0, 8.0, 16.0))   # Generate heightmap mesh (RAM and VRAM)
  model = LoadModelFromMesh(mesh)                                   # Load model from generated mesh

  SetMaterialTexture(model.material(0), MATERIAL_MAP_ALBEDO, texture) # Set map diffuse texture
  mapPosition = Vector3.create(-8.0, 0.0, -8.0)                        # Set model position

  UnloadImage(image)                    # Unload heightmap image from RAM, already uploaded to VRAM

  SetTargetFPS(60)                      # Set our game to run at 60 frames-per-second

  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

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
