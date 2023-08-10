require_relative 'util/setup_dll'
require_relative 'util/resource_path'

# generate a simple triangle mesh from code
def GenMeshCustom()
  mesh = Mesh.new
  mesh[:triangleCount] = 1
  mesh[:vertexCount] = mesh[:triangleCount] * 3

  sizeof_float = FFI.type_size(:float)
  mesh[:vertices] = MemAlloc(mesh[:vertexCount] * 3 * sizeof_float)
  mesh[:texcoords] = MemAlloc(mesh[:vertexCount] * 2 * sizeof_float)
  mesh[:normals] = MemAlloc(mesh[:vertexCount] * 3 * sizeof_float)

  # vertex at (0, 0, 0)
  mesh[:vertices].put_array_of_float32(0, [0, 0, 0])
  mesh[:normals].put_array_of_float32(0, [0, 1, 0])
  mesh[:texcoords].put_array_of_float32(0, [0, 0])

  # vertex at (1, 0, 2)
  mesh[:vertices].put_array_of_float32(3 * sizeof_float, [1, 0, 2])
  mesh[:normals].put_array_of_float32(3 * sizeof_float, [0, 1, 0])
  mesh[:texcoords].put_array_of_float32(2 * sizeof_float, [0.5, 1.0])

  # vertex at (2, 0, 0)
  mesh[:vertices].put_array_of_float32(6 * sizeof_float, [2, 0, 0])
  mesh[:normals].put_array_of_float32(6 * sizeof_float, [0, 1, 0])
  mesh[:texcoords].put_array_of_float32(4 * sizeof_float, [1, 0])

  # Upload mesh data from CPU (RAM) to GPU (VRAM) memory
  UploadMesh(mesh, false)

  return mesh
end

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - mesh generation")

  # We generate a checked image for texturing
  checked = GenImageChecked(2, 2, 1, 1, RED, GREEN)
  texture = LoadTextureFromImage(checked)
  UnloadImage(checked)

  models = [
    LoadModelFromMesh(GenMeshPlane(2, 2, 5, 5)),
    LoadModelFromMesh(GenMeshCube(2.0, 1.0, 2.0)),
    LoadModelFromMesh(GenMeshSphere(2, 32, 32)),
    LoadModelFromMesh(GenMeshHemiSphere(2, 16, 16)),
    LoadModelFromMesh(GenMeshCylinder(1, 2, 16)),
    LoadModelFromMesh(GenMeshTorus(0.25, 4.0, 16, 32)),
    LoadModelFromMesh(GenMeshKnot(1.0, 2.0, 16, 128)),
    LoadModelFromMesh(GenMeshPoly(5, 2.0)),
    LoadModelFromMesh(GenMeshCustom()),
  ]
  NUM_MODELS = models.length # Parametric 3d shapes to generate

  # Set checked texture as default diffuse component for all models material
  models.each do |model|
    SetMaterialTexture(model.material(0), MATERIAL_MAP_ALBEDO, texture)
  end

  # Define the camera to look into our 3d world
  camera = Camera.new
             .with_position(5.0, 5.0, 5.0)
             .with_target(0.0, 0.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  # Model drawing position
  position = Vector3.create(0.0, 0.0, 0.0)

  currentModel = 0

  SetTargetFPS(60)

  until WindowShouldClose()

    UpdateCamera(camera.pointer, CAMERA_ORBITAL)

    if IsMouseButtonPressed(MOUSE_BUTTON_LEFT)
      currentModel = (currentModel + 1) % NUM_MODELS
    end
    if IsKeyReleased(KEY_RIGHT)
      currentModel += 1
      currentModel = 0 if currentModel == NUM_MODELS
    elsif IsKeyReleased(KEY_LEFT)
      currentModel -= 1
      currentModel = NUM_MODELS - 1 if currentModel < 0
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)
        DrawModel(models[currentModel], position, 1.0, WHITE)
        DrawGrid(10, 1.0)
      EndMode3D()

      DrawRectangle(30, 400, 310, 30, Fade(SKYBLUE, 0.5))
      DrawRectangleLines(30, 400, 310, 30, Fade(DARKBLUE, 0.5))
      DrawText("MOUSE LEFT BUTTON to CYCLE PROCEDURAL MODELS", 40, 410, 10, BLUE)

      case currentModel
      when 0 then DrawText("PLANE", 680, 10, 20, DARKBLUE)
      when 1 then DrawText("CUBE", 680, 10, 20, DARKBLUE)
      when 2 then DrawText("SPHERE", 680, 10, 20, DARKBLUE)
      when 3 then DrawText("HEMISPHERE", 640, 10, 20, DARKBLUE)
      when 4 then DrawText("CYLINDER", 680, 10, 20, DARKBLUE)
      when 5 then DrawText("TORUS", 680, 10, 20, DARKBLUE)
      when 6 then DrawText("KNOT", 680, 10, 20, DARKBLUE)
      when 7 then DrawText("POLY", 680, 10, 20, DARKBLUE)
      when 8 then DrawText("Parametric(custom)", 580, 10, 20, DARKBLUE)
      else break
      end
    EndDrawing()
  end

  UnloadTexture(texture)

  models.each do |model|
    UnloadModel(model)
  end

  CloseWindow()
end
