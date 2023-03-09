require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - model animation")

  # Define the camera to look into our 3d world
  camera = Camera.new
  camera[:position] = Vector3.create(10.0, 10.0, 10.0)
  camera[:target] = Vector3.create(0.0, 5.0, 0.0)
  camera[:up] = Vector3.create(0.0, 1.0, 0.0)
  camera[:fovy] = 45.0
  camera[:projection] = CAMERA_PERSPECTIVE

  model = LoadModel(RAYLIB_MODELS_PATH + "resources/models/iqm/guy.iqm") # Load the animated model mesh and basic data
  texture = LoadTexture(RAYLIB_MODELS_PATH + "resources/models/iqm/guytex.png") # Load model texture and set material
  SetMaterialTexture(model.material(0), MATERIAL_MAP_ALBEDO, texture)

  position = Vector3.create

  # Load animation data
  modelanims = ModelAnimations.new.setup(RAYLIB_MODELS_PATH + "resources/models/iqm/guyanim.iqm")
  animFrameCounter = 0

  SetTargetFPS(60)

  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

    # Play animation when spacebar is held down
    if IsKeyDown(KEY_SPACE)
      animFrameCounter += 1
      UpdateModelAnimation(model, modelanims.anim(0), animFrameCounter)
      animFrameCounter = 0 if animFrameCounter >= modelanims.frame_count(0)
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawModelEx(model, position, Vector3.create(1.0, 0.0, 0.0), -90.0, Vector3.create(1.0, 1.0, 1.0), WHITE)
        model.bone_count.times do |bone|
          transform = modelanims.bone_transform_of_frame_pose(0, animFrameCounter, bone)
          DrawCube(transform.t, 0.2, 0.2, 0.2, RED)
        end
        DrawGrid(10, 1.0)
      EndMode3D()

      DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, 10, 20, MAROON)
      DrawText("(c) Guy IQM 3D model by @culacant", screenWidth - 200, screenHeight - 20, 10, GRAY)
    EndDrawing()
  end

  UnloadTexture(texture)
  modelanims.cleanup
  UnloadModel(model)

  CloseWindow()
end
