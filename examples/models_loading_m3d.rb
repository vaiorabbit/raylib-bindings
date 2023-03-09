require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - M3D model loading")

  # Define the camera to look into our 3d world
  camera = Camera.new
  camera.position.set(1.5, 1.5, 1.5)
  camera.target.set(0.0, 0.4, 0.0)
  camera.up.set(0.0, 1.0, 0.0)
  camera.fovy = 45.0
  camera.projection = CAMERA_PERSPECTIVE

  modelFileName = RAYLIB_MODELS_PATH + "resources/models/m3d/CesiumMan.m3d"

  model = LoadModel(modelFileName)

  currentModel = 0
  position = Vector3.create(0.0, 0.0, 0.0) # Set model position

  drawMesh = true
  drawSkeleton = true
  animPlaying = false # Store anim state, what to draw

  # Load animation data
  modelanims = ModelAnimations.new.setup(modelFileName)
  animFrameCounter = 0
  animId = 0

  SetTargetFPS(60)

  until WindowShouldClose()

    UpdateCamera(camera.pointer, CAMERA_FREE)

    if modelanims.anims_count > 0
      # Play animation when spacebar is held down (or step one frame with N)
      if IsKeyDown(KEY_SPACE) || IsKeyPressed(KEY_N)
        animFrameCounter += 1
        animFrameCounter = 0 if animFrameCounter >= modelanims.frame_count(animId)
        UpdateModelAnimation(model, modelanims.anim(animId), animFrameCounter)
        animPlaying = true
      end
      # Select animation by pressing A
      if IsKeyPressed(KEY_A)
        animFrameCounter = 0
        animId += 1
        animId = 0 if animId >= modelanims.anims_count
        UpdateModelAnimation(model, modelanims.anim(animId), 0)
        animPlaying = true
      end
    end

    # Toggle skeleton drawing
    drawSkeleton = !drawSkeleton if IsKeyPressed(KEY_S)
    # Toggle mesh drawing
    drawMesh = !drawMesh if IsKeyPressed(KEY_M)

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
          (model.bone_count - 1).times do |i|
            bone = model.bone_info(i) # BoneInfo
            # By default the model is loaded in bind-pose by LoadModel(). 
            # But if UpdateModelAnimation() has been called at least once 
            # then the model is already in animation pose, so we need the animated skeleton
            if !animPlaying || modelanims.anims_count == 0
              # Display the bind-pose skeleton
              bindPose = model.bind_pose_transform(i) # Transform
              DrawCube(bindPose, 0.04, 0.04, 0.04, RED)
              if bone.parent_bone_index >= 0
                parentBindPose = model.bind_pose_transform(bone.parent_bone_index) # Transform
                DrawLine3D(bindPose.t, parentBindPose.t, RED)
              end
            else
              # Display the frame-pose skeleton
              transform = modelanims.bone_transform_of_frame_pose(animId, animFrameCounter, i)
              DrawCube(transform.t, 0.05, 0.05, 0.05, RED)
              animBone = modelanims.bone_info(animId, i) # BoneInfo
              if animBone.parent_bone_index >= 0
                parentTransform = modelanims.bone_transform_of_frame_pose(animId, animFrameCounter, animBone.parent_bone_index) # Transform
                DrawLine3D(transform.t, parentTransform.t, RED)
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

  modelanims.cleanup

  UnloadModel(model)

  CloseWindow()
end
