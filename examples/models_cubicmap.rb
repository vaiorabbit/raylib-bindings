require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - cubesmap loading and drawing")

  # Define the camera to look into our 3d world
  camera = Camera.new
             .with_position(16.0, 14.0, 16.0)
             .with_target(0.0, 0.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  image = LoadImage(RAYLIB_MODELS_PATH + "resources/cubicmap.png") # Load cubicmap image (RAM)
  cubicmap = LoadTextureFromImage(image)                           # Convert image to texture to display (VRAM)

  mesh = GenMeshCubicmap(image, Vector3.create(1.0, 1.0, 1.0))
  model = LoadModelFromMesh(mesh)

  # NOTE: By default each cube is mapped to one part of texture atlas
  texture = LoadTexture(RAYLIB_MODELS_PATH + "resources/cubicmap_atlas.png") # Load map texture
  SetMaterialTexture(model.material(0), MATERIAL_MAP_ALBEDO, texture)

  mapPosition = Vector3.create(-16.0, 0.0, -8.0) # Set model position

  UnloadImage(image) # Unload cubesmap image from RAM, already uploaded to VRAM

  SetTargetFPS(60)

  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawModel(model, mapPosition, 1.0, WHITE)
      EndMode3D()

      DrawTextureEx(cubicmap, Vector2.create(screenWidth - cubicmap[:width]*4.0 - 20, 20.0), 0.0, 4.0, WHITE)
      DrawRectangleLines(screenWidth - cubicmap[:width]*4 - 20, 20, cubicmap[:width]*4, cubicmap[:height]*4, GREEN)

      DrawText("cubicmap image used to", 658, 90, 10, GRAY)
      DrawText("generate map 3d model", 658, 104, 10, GRAY)
    EndDrawing()
  end

  UnloadTexture(cubicmap) # Unload cubicmap texture
  UnloadTexture(texture)  # Unload map texture
  UnloadModel(model)      # Unload map model

  CloseWindow()
end
