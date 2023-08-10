require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  InitWindow(800, 450, "Yet Another Ruby-raylib bindings - loading gltf")

  # Define the camera to look into our 3d world
  camera = Camera.new
             .with_position(5.0, 5.0, 5.0)
             .with_target(0.0, 2.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  model = LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/robot.glb")

  animIndex = 0
  animFrameCounter = 0
  modelanims = ModelAnimations.new.setup(RAYLIB_MODELS_PATH + "resources/models/gltf/robot.glb")

  position = Vector3.create(0.0, 0.0, 0.0) # Set model position

  SetTargetFPS(60)

  until WindowShouldClose()
    animIndex = if IsKeyPressed(KEY_UP)
                  (animIndex + 1) % modelanims.anims_count
                elsif IsKeyPressed(KEY_DOWN)
                  (animIndex + modelanims.anims_count - 1) % modelanims.anims_count
                else
                  animIndex
                end

    UpdateModelAnimation(model, modelanims.anim(animIndex), animFrameCounter)
    animFrameCounter = (animFrameCounter + 1) % modelanims.frame_count(animIndex)

    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

    BeginDrawing()
      ClearBackground(WHITE)
      BeginMode3D(camera)
        DrawModel(model, position, 1.0, WHITE)
        DrawGrid(10, 1.0)
      EndMode3D()

      DrawText("Use the UP/DOWN arrow keys to switch animation", 10, 10, 20, GRAY)
    EndDrawing()
  end

  modelanims.cleanup
  UnloadModel(model)

  CloseWindow()
end
