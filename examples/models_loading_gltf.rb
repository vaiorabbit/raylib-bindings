require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - model")

  # Define the camera to look into our 3d world
  camera = Camera.new
  camera[:position] = Vector3.create(10.0, 10.0, 10.0)
  camera[:target] = Vector3.create(0.0, 0.0, 0.0)
  camera[:up] = Vector3.create(0.0, 1.0, 0.0)
  camera[:fovy] = 45.0
  camera[:projection] = CAMERA_PERSPECTIVE

  MAX_GLTF_MODELS = 1
  models = [
    # LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/raylib_32x32.glb"),
    # LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/rigged_figure.glb"),
    # LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/GearboxAssy.glb"),
    # LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/BoxAnimated.glb"),
    # LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/AnimatedTriangle.gltf"),
    # LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/AnimatedMorphCube.glb"),
    # LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/vertex_colored_object.glb"),
    # LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/girl.glb"),
    LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/robot.glb"),
  ]

  currentModel = 0
  position = Vector3.create(0.0, 0.0, 0.0) # Set model position

  SetCameraMode(camera, CAMERA_FREE)

  SetTargetFPS(60)

  until WindowShouldClose()

    UpdateCamera(camera.pointer)

    if IsKeyReleased(KEY_RIGHT)
      currentModel += 1
      currentModel = 0 if currentModel == MAX_GLTF_MODELS
    end
    if IsKeyReleased(KEY_LEFT)
      currentModel -= 1
      currentModel = MAX_GLTF_MODELS - 1 if currentModel < 0
    end

    BeginDrawing()
      ClearBackground(SKYBLUE)
      BeginMode3D(camera)
        DrawModel(models[currentModel], position, 1.0, WHITE)
        DrawGrid(10, 1.0)
      EndMode3D()
    EndDrawing()
  end

  models.each do |model|
    UnloadModel(model)
  end

  CloseWindow()
end
