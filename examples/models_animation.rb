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

  materials_0 = Material.new(model[:materials])
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

  SetCameraMode(camera, CAMERA_ORBITAL)

  SetTargetFPS(60)

  framePoses = anims[0][:framePoses] # Transform**
  until WindowShouldClose()
    UpdateCamera(camera.pointer)

    # Play animation when spacebar is held down
    if IsKeyDown(KEY_SPACE)
      animFrameCounter += 1
      UpdateModelAnimation(model, anims[0], animFrameCounter)
      animFrameCounter = 0 if animFrameCounter >= anims[0][:frameCount]
    end

    framePose = framePoses + animFrameCounter * FFI::NativeType::POINTER.size # Transform*

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        # [TODO] Fix matrix copy
        # - In C, DrawModelEx uses the whole copy of `model` on stack, which will never affect the content of original `model`.
        #   But Ruby FFI seems to pass the reference of `model` to DrawModelEx, which results in transform accumulation (`model` get rotated -90 degree around X axis every frame).
        #   So here I copy the transform into `mtx_clone` and copy back this to the original after finished calling DrawModelEx.
        # - Other DrawXXX members (DrawModel, DrawModelWires, DrawModelWiresEx) are free from this problem.
        #   - They call DrawModelEx in C layer, which will use the copy of `model` on stack.
        mtx_clone = model[:transform].clone
        DrawModelEx(model, position, Vector3.create(1.0, 0.0, 0.0), -90.0, Vector3.create(1.0, 1.0, 1.0), WHITE)
        model[:transform] = mtx_clone

        model[:boneCount].times do |i|
          transform = Transform.new(framePose.read_pointer + i * Transform.size)
          DrawCube(transform[:translation], 0.2, 0.2, 0.2, RED)
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
