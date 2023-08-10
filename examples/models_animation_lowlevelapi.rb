require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - model animation")

  # Define the camera to look into our 3d world
  camera = Camera.new
             .with_position(10.0, 10.0, 10.0)
             .with_target(0.0, 5.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  model = LoadModel(RAYLIB_MODELS_PATH + "resources/models/iqm/guy.iqm") # Load the animated model mesh and basic data
  texture = LoadTexture(RAYLIB_MODELS_PATH + "resources/models/iqm/guytex.png") # Load model texture and set material

  materials_0 = Material.new(model.materials)
  SetMaterialTexture(materials_0, MATERIAL_MAP_ALBEDO, texture)

  position = Vector3.create(0, 0, 0)

  # Load animation data
  animsCount_buf = FFI::MemoryPointer.new(:int, 1)
  anim_ptrs = LoadModelAnimations(RAYLIB_MODELS_PATH + "resources/models/iqm/guyanim.iqm", animsCount_buf)
  animsCount = animsCount_buf.read_int
  anims = animsCount.times.map do |i|
    ModelAnimation.new(anim_ptrs + i * ModelAnimation.size)
  end
  animFrameCounter = 0

  SetTargetFPS(60)

  framePoses = anims[0].framePoses # Transform**
  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

    # Play animation when spacebar is held down
    if IsKeyDown(KEY_SPACE)
      animFrameCounter += 1
      UpdateModelAnimation(model, anims[0], animFrameCounter)
      animFrameCounter = 0 if animFrameCounter >= anims[0].frameCount
    end

    framePose = framePoses + animFrameCounter * FFI::NativeType::POINTER.size # Transform*

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawModelEx(model, position, Vector3.create(1.0, 0.0, 0.0), -90.0, Vector3.create(1.0, 1.0, 1.0), WHITE)
        model.boneCount.times do |i|
          transform = Transform.new(framePose.read_pointer + i * Transform.size)
          DrawCube(transform.translation, 0.2, 0.2, 0.2, RED)
        end
        DrawGrid(10, 1.0)
      EndMode3D()

      DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, 10, 20, MAROON)
      DrawText("(c) Guy IQM 3D model by @culacant", screenWidth - 200, screenHeight - 20, 10, GRAY)
    EndDrawing()
  end

  UnloadTexture(texture)

  # Unload model animations data
  animsCount.times do |i|
    UnloadModelAnimation(anims[i])
  end
  MemFree(anim_ptrs)

  UnloadModel(model)

  CloseWindow()
end
