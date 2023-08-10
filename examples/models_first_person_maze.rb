require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - first person maze")

  # Define the camera to look into our 3d world
  camera = Camera.new
             .with_position(0.2, 0.4, 0.2)
             .with_target(0.0, 0.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  imMap = LoadImage(RAYLIB_MODELS_PATH + "resources/cubicmap.png") # Load cubicmap image (RAM)
  cubicmap = LoadTextureFromImage(imMap)                           # Convert image to texture to display (VRAM)
  mesh = GenMeshCubicmap(imMap, Vector3.create(1.0, 1.0, 1.0))
  model = LoadModelFromMesh(mesh)

  # NOTE: By default each cube is mapped to one part of texture atlas
  texture = LoadTexture(RAYLIB_MODELS_PATH + "resources/cubicmap_atlas.png") # Load map texture
  SetMaterialTexture(model.material(0), MATERIAL_MAP_ALBEDO, texture)

  # Get map image data to be used for collision detection
  mapPixels = LoadImageColors(imMap)
  UnloadImage(imMap) # Unload image from RAM

  mapPosition = Vector3.create(-16.0, 0.0, -8.0) # Set model position

  SetTargetFPS(60)

  until WindowShouldClose()
    oldCamPos = Vector3.copy_from(camera.position)

    UpdateCamera(camera.pointer, CAMERA_FIRST_PERSON)

    # Check player collision (we simplify to 2D collision detection)
    playerPos = Vector2.create(camera.position.x, camera.position.z)
    playerRadius = 0.1 # Collision radius (player is modelled as a cilinder for collision)

    playerCellX = (playerPos.x - mapPosition.x + 0.5).to_i
    playerCellY = (playerPos.y - mapPosition.z + 0.5).to_i

    # Out-of-limits security check
    if playerCellX < 0
      playerCellX = 0
    elsif playerCellX >= cubicmap.width
      playerCellX = cubicmap.width - 1
    end

    if playerCellY < 0
      playerCellY = 0
    elsif playerCellY >= cubicmap.height
      playerCellY = cubicmap.height - 1
    end

    # Check map collisions using image data and player position
    # TODO: Improvement: Just check player surrounding cells for collision
    cubicmap.height.times do |y|
      cubicmap.width.times do |x|
        pixel = Color.new(mapPixels + Color.size * (y*cubicmap.width + x))
        if (pixel.r == 255) && # Collision: white pixel, only check R channel
           CheckCollisionCircleRec(playerPos, playerRadius, Rectangle.create(mapPosition.x - 0.5 + x*1.0, mapPosition.z - 0.5 + y*1.0, 1.0, 1.0))
          # Collision detected, reset camera position
          camera.position.set(oldCamPos.x, oldCamPos.y, oldCamPos.z)
        end
      end
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawModel(model, mapPosition, 1.0, WHITE)
      EndMode3D()

      DrawTextureEx(cubicmap, Vector2.create(screenWidth - cubicmap.width*4.0 - 20, 20.0), 0.0, 4.0, WHITE)
      DrawRectangleLines(screenWidth - cubicmap.width*4 - 20, 20, cubicmap.width*4, cubicmap.height*4, GREEN)

      # Draw player position radar
      DrawRectangle(GetScreenWidth() - cubicmap.width*4 - 20 + playerCellX*4, 20 + playerCellY*4, 4, 4, RED)
      DrawFPS(10, 10)
    EndDrawing()
  end

  UnloadImageColors(mapPixels)  # Unload color array
  UnloadTexture(cubicmap)       # Unload cubicmap texture
  UnloadTexture(texture)        # Unload map texture
  UnloadModel(model)            # Unload map model

  CloseWindow()
end
