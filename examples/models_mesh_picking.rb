require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  SetConfigFlags(FLAG_MSAA_4X_HINT | FLAG_WINDOW_HIGHDPI)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - mesh picking")

  camera = Camera.new
  camera[:position] = Vector3.create(20.0, 20.0, 20.0)
  camera[:target] = Vector3.create(0.0, 8.0, 0.0)
  camera[:up] = Vector3.create(0.0, 1.6, 0.0)
  camera[:fovy] = 45.0
  camera[:projection] = CAMERA_PERSPECTIVE

  ray = Ray.new

  tower = LoadModel(RAYLIB_MODELS_PATH + "resources/models/obj/turret.obj")
  texture = LoadTexture(RAYLIB_MODELS_PATH + "resources/models/obj/turret_diffuse.png")

  # Set map diffuse texture
  # [Ruby-raylib TODO] prepare convenient accessors for Material/Model members
  materials_0 = Material.new(tower[:materials])
  materialMap = MaterialMap.new(materials_0[:maps]) # == model.materials.maps[MATERIAL_MAP_DIFFUSE]
  materialMap[:texture] = texture # Set map diffuse texture

  towerPos = Vector3.create(0.0, 0.0, 0.0)
  towerBBox = GetMeshBoundingBox(Mesh.new(tower[:meshes]))

  # Ground quad
  g0 = Vector3.create(-50.0, 0.0, -50.0)
  g1 = Vector3.create(-50.0, 0.0,  50.0)
  g2 = Vector3.create( 50.0, 0.0,  50.0)
  g3 = Vector3.create( 50.0, 0.0, -50.0)

  # Test triangle
  ta = Vector3.create(-25.0, 0.5, 0.0)
  tb = Vector3.create(-4.0, 2.5, 1.0)
  tc = Vector3.create(-8.0, 6.5, 0.0)

  bary = Vector3.create(0.0, 0.0, 0.0)

  # Test sphere
  sp = Vector3.create(-30.0, 5.0, 5.0)
  sr = 4.0

  SetCameraMode(camera, CAMERA_FREE)

  SetTargetFPS(60)

  until WindowShouldClose()

    # Display information about closest hit
    collision = RayCollision.new
    hitObjectName = "None"
    collision[:distance] = Float::MAX
    collision[:hit] = false
    cursorColor = WHITE

    # Get ray and test against objects
    ray = GetMouseRay(GetMousePosition(), camera)

    # Check ray collision against ground quad
    groundHitInfo = GetRayCollisionQuad(ray, g0, g1, g2, g3)
    if groundHitInfo[:hit] && (groundHitInfo[:distance] < collision[:distance])
      collision = groundHitInfo
      cursorColor = GREEN
      hitObjectName = "Ground"
    end

    # Check ray collision against test triangle
    triHitInfo = GetRayCollisionTriangle(ray, ta, tb, tc)
    if (triHitInfo[:hit]) && (triHitInfo[:distance] < collision[:distance])
      collision = triHitInfo
      cursorColor = PURPLE
      hitObjectName = "Triangle"
      bary = Vector3Barycenter(collision[:point], ta, tb, tc)
    end

    # Check ray collision against test sphere
    sphereHitInfo = GetRayCollisionSphere(ray, sp, sr)
    if (sphereHitInfo[:hit]) && (sphereHitInfo[:distance] < collision[:distance])
      collision = sphereHitInfo
      cursorColor = ORANGE
      hitObjectName = "Sphere"
    end

    # Check ray collision against bounding box first, before trying the full ray-mesh test
    boxHitInfo = GetRayCollisionBox(ray, towerBBox)
    if (boxHitInfo[:hit]) && (boxHitInfo[:distance] < collision[:distance])
      collision = boxHitInfo
      cursorColor = ORANGE
      hitObjectName = "Box"

      # Check ray collision against model
      meshHitInfo = nil
      tower[:meshCount].times do |m|
        # NOTE: We consider the model.transform for the collision check but 
        # it can be checked against any transform Matrix, used when checking against same
        # model drawn multiple times with multiple transforms
        mesh = Mesh.new(tower[:meshes] + m * FFI::NativeType::POINTER.size)
        meshHitInfo = GetRayCollisionMesh(ray, mesh, tower[:transform])
      end

      if meshHitInfo && meshHitInfo[:hit]
        collision = meshHitInfo
        cursorColor = ORANGE
        hitObjectName = "Mesh"
      end
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      BeginMode3D(camera)

        # Draw the tower
        # WARNING: If scale is different than 1.0f,
        # not considered by GetRayCollisionModel()
        DrawModel(tower, towerPos, 1.0, WHITE)

        # Draw the test triangle
        DrawLine3D(ta, tb, PURPLE)
        DrawLine3D(tb, tc, PURPLE)
        DrawLine3D(tc, ta, PURPLE)

        # Draw the test sphere
        DrawSphereWires(sp, sr, 8, 8, PURPLE)

        # Draw the mesh bbox if we hit it
        DrawBoundingBox(towerBBox, LIME) if boxHitInfo[:hit]

        # If we hit something, draw the cursor at the hit point
        if collision[:hit]
          DrawCube(collision[:point], 0.3, 0.3, 0.3, cursorColor)
          DrawCubeWires(collision[:point], 0.3, 0.3, 0.3, RED)
          normalEnd = Vector3.new
          normalEnd[:x] = collision[:point][:x] + collision[:normal][:x]
          normalEnd[:y] = collision[:point][:y] + collision[:normal][:y]
          normalEnd[:z] = collision[:point][:z] + collision[:normal][:z]
          DrawLine3D(collision[:point], normalEnd, RED)
        end
        DrawRay(ray, MAROON)
        DrawGrid(10, 10.0)
      EndMode3D()

      # Draw some debug GUI text
      DrawText(TextFormat("Hit Object: %s", :string, hitObjectName), 10, 50, 10, BLACK)
      if collision[:hit]
        ypos = 70
        DrawText(TextFormat("Distance: %3.2f", :float, collision[:distance]), 10, ypos, 10, BLACK)
        DrawText(TextFormat("Hit Pos: %3.2f %3.2f %3.2f",
                              :float, collision[:point][:x],
                              :float, collision[:point][:y],
                              :float, collision[:point][:z]), 10, ypos + 15, 10, BLACK)
          DrawText(TextFormat("Hit Norm: %3.2f %3.2f %3.2f",
                              :float, collision[:normal][:x],
                              :float, collision[:normal][:y],
                              :float, collision[:normal][:z]), 10, ypos + 30, 10, BLACK)
          if triHitInfo[:hit] && TextIsEqual(hitObjectName, "Triangle")
            DrawText(TextFormat("Barycenter: %3.2f %3.2f %3.2f", :float, bary[:x], :float, bary[:y], :float, bary[:z]), 10, ypos + 45, 10, BLACK)
          end
      end

      DrawText("Use Mouse to Move Camera", 10, 430, 10, GRAY)
      DrawText("(c) Turret 3D model by Alberto Cano", screenWidth - 200, screenHeight - 20, 10, GRAY)
      DrawFPS(10, 10)

    EndDrawing()
  end

  UnloadModel(tower)
  UnloadTexture(texture)

  CloseWindow()
end
