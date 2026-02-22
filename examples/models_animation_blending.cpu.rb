require_relative 'util/setup_dll'
require_relative 'util/resource_path'

def clamp(value, min_value, max_value)
  [[value, min_value].max, max_value].min
end

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - animation blending")

  camera = Camera.new
             .with_position(8.0, 8.0, 8.0)
             .with_target(0.0, 2.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  character_model = LoadModel(RAYLIB_MODELS_PATH + "resources/models/gltf/robot.glb")

  modelanims = ModelAnimations.new.setup(RAYLIB_MODELS_PATH + "resources/models/gltf/robot.glb")
  anims_count = modelanims.anims_count

  anim_index0 = 0
  anim_index1 = 0
  anim_current_frame = 0
  blend_factor = 0.5

  DisableCursor()
  SetTargetFPS(60)

  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_THIRD_PERSON)

    if IsKeyPressed(KEY_T)
      anim_index0 = (anim_index0 + 1) % anims_count
    elsif IsKeyPressed(KEY_G)
      anim_index0 = (anim_index0 + anims_count - 1) % anims_count
    end

    if IsKeyPressed(KEY_Y)
      anim_index1 = (anim_index1 + 1) % anims_count
    elsif IsKeyPressed(KEY_H)
      anim_index1 = (anim_index1 + anims_count - 1) % anims_count
    end

    if IsKeyPressed(KEY_U)
      blend_factor = clamp(blend_factor - 0.1, 0.0, 1.0)
    elsif IsKeyPressed(KEY_J)
      blend_factor = clamp(blend_factor + 0.1, 0.0, 1.0)
    end

    anim_current_frame += 1

    anim0 = modelanims.anim(anim_index0)
    anim1 = modelanims.anim(anim_index1)

    frame0 = anim_current_frame % [anim0.frameCount, 1].max
    frame1 = anim_current_frame % [anim1.frameCount, 1].max

    UpdateModelAnimationBonesLerp(character_model, anim0, frame0, anim1, frame1, blend_factor)
    UpdateModelVertsToCurrentBones(character_model)

    BeginDrawing()
      ClearBackground(RAYWHITE)

      BeginMode3D(camera)
        DrawModel(character_model, Vector3.create(0.0, 0.0, 0.0), 1.0, WHITE)
        DrawGrid(10, 1.0)
      EndMode3D()

      DrawText("Use U/J to adjust blend factor", 10, 10, 20, GRAY)
      DrawText("Use T/G to switch first animation", 10, 30, 20, GRAY)
      DrawText("Use Y/H to switch second animation", 10, 50, 20, GRAY)
      DrawText("Animation indices: #{anim_index0}, #{anim_index1}", 10, 70, 20, BLACK)
      DrawText(format("Blend Factor: %.2f", blend_factor), 10, 86, 20, BLACK)
    EndDrawing()
  end

  modelanims.cleanup
  UnloadModel(character_model)

  CloseWindow()
end
