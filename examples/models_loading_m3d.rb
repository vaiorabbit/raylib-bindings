require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - M3D model loading")

  # Define the camera to look into our 3d world
  camera = Camera.new
  camera[:position] = Vector3.create(1.5, 1.5, 1.5)
  camera[:target] = Vector3.create(0.0, 0.4, 0.0)
  camera[:up] = Vector3.create(0.0, 1.0, 0.0)
  camera[:fovy] = 45.0
  camera[:projection] = CAMERA_PERSPECTIVE

  modelFileName = RAYLIB_MODELS_PATH + "resources/models/m3d/CesiumMan.m3d"

  model = LoadModel(modelFileName)

  currentModel = 0
  position = Vector3.create(0.0, 0.0, 0.0) # Set model position

  drawMesh = true
  drawSkeleton = true
  animPlaying = false # Store anim state, what to draw

  # Load animation data
  animsCount_buf = FFI::MemoryPointer.new(:uint, 1)
  anim_ptrs = LoadModelAnimations(modelFileName, animsCount_buf)
  animsCount = animsCount_buf.read_uint
  anims = animsCount.times.map do |i|
    ModelAnimation.new(anim_ptrs + i * ModelAnimation.size)
  end
  animFrameCounter = 0
  animId = 0

  SetCameraMode(camera, CAMERA_FREE)

  SetTargetFPS(60)

  bones = model[:bones] # BoneInfo*

  until WindowShouldClose()

    UpdateCamera(camera.pointer)

    if animsCount > 0
      # Play animation when spacebar is held down (or step one frame with N)
      if IsKeyDown(KEY_SPACE) || IsKeyPressed(KEY_N)
        animFrameCounter += 1
        animFrameCounter = 0 if animFrameCounter >= anims[animId][:frameCount]
        UpdateModelAnimation(model, anims[animId], animFrameCounter)
        animPlaying = true
      end
      # Select animation by pressing A
      if IsKeyPressed(KEY_A)
        animFrameCounter = 0
        animId += 1
        animId = 0 if animId >= animsCount
        UpdateModelAnimation(model, anims[animId], 0)
        animPlaying = true
      end
    end

    # Toggle skeleton drawing
    drawSkeleton = !drawSkeleton if IsKeyPressed(KEY_S)
    # Toggle mesh drawing
    drawMesh = !drawMesh if IsKeyPressed(KEY_M)

    bindPoses = model[:bindPose] # Transform*
    framePoses = anims[animId][:framePoses] # Transform**
    framePose = framePoses + animFrameCounter * FFI::NativeType::POINTER.size # Transform*

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        # Draw 3d model with texture
        DrawModel(model, position, 1.0, WHITE) if drawMesh
        # Draw the animated skeleton
        if drawSkeleton
          # Loop to (boneCount - 1) because the last one is a special "no bone" bone, 
          # needed to workaround buggy models
          # without a -1, we would always draw a cube at the origin
          (model[:boneCount] - 1).times do |i|
            bone = BoneInfo.new(bones + i * BoneInfo.size) # BoneInfo
            # By default the model is loaded in bind-pose by LoadModel(). 
            # But if UpdateModelAnimation() has been called at least once 
            # then the model is already in animation pose, so we need the animated skeleton
            if !animPlaying || animsCount == 0
              # Display the bind-pose skeleton
              bindPose = Transform.new(bindPoses + i * Transform.size) # Transform
              DrawCube(bindPose, 0.04, 0.04, 0.04, RED)
              if bone[:parent] >= 0
                parentBindPose = Transform.new(bindPoses + bone[:parent] * Transform.size) # Transform
                DrawLine3D(bindPose[:translation], parentBindPose[:translation], RED)
              end
            else
              # Display the frame-pose skeleton
              transform = Transform.new(framePose.read_pointer + i * Transform.size)
              DrawCube(transform[:translation], 0.05, 0.05, 0.05, RED)
              animBone = BoneInfo.new(anims[animId][:bones] + i * BoneInfo.size)
              if animBone[:parent] >= 0
                parentTransform = Transform.new(framePose.read_pointer + animBone[:parent] * Transform.size)
                DrawLine3D(transform[:translation], parentTransform[:translation], RED)
              end
            end
          end
        end
        DrawGrid(10, 1.0)
      EndMode3D()

    DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, GetScreenHeight() - 60, 10, MAROON)
    DrawText("PRESS A to CYCLE THROUGH ANIMATIONS", 10, GetScreenHeight() - 40, 10, DARKGRAY)
    DrawText("PRESS M to toggle MESH, S to toggle SKELETON DRAWING", 10, GetScreenHeight() - 20, 10, DARKGRAY)
    DrawText("(c) CesiumMan model by KhronosGroup", GetScreenWidth() - 210, GetScreenHeight() - 20, 10, GRAY)
    EndDrawing()
  end

  animsCount.times do |i|
    UnloadModelAnimation(anims[i])
  end
  MemFree(anim_ptrs)

  UnloadModel(model)

  CloseWindow()
end
