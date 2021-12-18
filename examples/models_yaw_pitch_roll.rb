require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  SetConfigFlags(FLAG_MSAA_4X_HINT | FLAG_WINDOW_HIGHDPI)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - plane rotations (yaw, pitch, roll)")

  camera = Camera.new
  camera[:position] = Vector3.create(0.0, 50.0, -120.0)
  camera[:target] = Vector3.create(0.0, 0.0, 0.0)
  camera[:up] = Vector3.create(0.0, 1.0, 0.0)
  camera[:fovy] = 30.0
  camera[:projection] = CAMERA_PERSPECTIVE

  model = LoadModel(RAYLIB_MODELS_PATH + "resources/models/obj/plane.obj")                  # Load model
  texture = LoadTexture(RAYLIB_MODELS_PATH + "resources/models/obj/plane_diffuse.png")  # Load model texture

  # Set map diffuse texture
  # [Ruby-raylib TODO] prepare convenient accessors for Material/Model members
  materials_0 = Material.new(model[:materials])
  materialMap = MaterialMap.new(materials_0[:maps]) # == model.materials.maps[MATERIAL_MAP_DIFFUSE]
  materialMap[:texture] = texture # Set map diffuse texture

  pitch = 0.0
  roll = 0.0
  yaw = 0.0

  SetTargetFPS(60)

  until WindowShouldClose()

    # Plane pitch (x-axis) controls
    if IsKeyDown(KEY_DOWN)
      pitch += 0.6
    elsif IsKeyDown(KEY_UP)
      pitch -= 0.6
    else
      if pitch > 0.3
        pitch -= 0.3
      elsif pitch < -0.3
        pitch += 0.3
      end
    end

    # Plane yaw (y-axis) controls
    if IsKeyDown(KEY_S)
      yaw += 1.0
    elsif IsKeyDown(KEY_A)
      yaw -= 1.0
    else
      if yaw > 0.0
        yaw -= 0.5
      elsif yaw < 0.0
        yaw += 0.5
      end
    end

    # Plane roll (z-axis) controls
    if IsKeyDown(KEY_LEFT)
      roll += 1.0
    elsif IsKeyDown(KEY_RIGHT)
      roll -= 1.0
    else
      if roll > 0.0
        roll -= 0.5
      elsif roll < 0.0
        roll += 0.5
      end
    end

    # Tranformation matrix for rotations
    model[:transform] = MatrixRotateXYZ(Vector3.create(DEG2RAD*pitch, DEG2RAD*yaw, DEG2RAD*roll))

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawModel(model, Vector3.create(0.0, -8.0, 0.0), 1.0, WHITE)
        DrawGrid(10, 10.0)
      EndMode3D()

      # Draw controls info
      DrawRectangle(30, 370, 260, 70, Fade(GREEN, 0.5))
      DrawRectangleLines(30, 370, 260, 70, Fade(DARKGREEN, 0.5))
      DrawText("Pitch controlled with: KEY_UP / KEY_DOWN", 40, 380, 10, DARKGRAY)
      DrawText("Roll controlled with: KEY_LEFT / KEY_RIGHT", 40, 400, 10, DARKGRAY)
      DrawText("Yaw controlled with: KEY_A / KEY_S", 40, 420, 10, DARKGRAY)

      DrawText("(c) WWI Plane Model created by GiaHanLam", screenWidth - 240, screenHeight - 20, 10, DARKGRAY)
    EndDrawing()
  end

  UnloadModel(model)

  CloseWindow()
end
