require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  SetConfigFlags(FLAG_MSAA_4X_HINT)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - physics demo")

  physics_bodies = []

  # Physac logo drawing position
  logoX = screenWidth - MeasureText("Physac", 30) - 10
  logoY = 15

  # Initialize physics and default physics bodies
  InitPhysics()

  # Create floor rectangle physics body
  floor = PhysicsBodyData.new(CreatePhysicsBodyRectangle(Vector2.create(screenWidth/2.0, screenHeight.to_f), 500, 100, 10))
  floor[:enabled] = false # Disable body state to convert it to static (no dynamics, but collisions)

  # Create obstacle circle physics body
  circle = PhysicsBodyData.new(CreatePhysicsBodyCircle(Vector2.create(screenWidth/2.0, screenHeight/2.0), 45, 10))
  circle[:enabled] = false # Disable body state to convert it to static (no dynamics, but collisions)

  SetTargetFPS(60)

  until WindowShouldClose()

    RunPhysicsStep() # Update physics system
    if IsKeyPressed(KEY_R) # Reset physics system
      # ResetPhysics()
      physics_bodies.each do |body|
        DestroyPhysicsBody(body)
      end
      physics_bodies.clear

      floor = PhysicsBodyData.new(CreatePhysicsBodyRectangle(Vector2.create(screenWidth/2.0, screenHeight.to_f), 500, 100, 10))
      floor[:enabled] = false

      circle = PhysicsBodyData.new(CreatePhysicsBodyCircle(Vector2.create(screenWidth/2.0, screenHeight/2.0), 45, 10))
      circle[:enabled] = false
    end

    # Physics body creation inputs
    if IsMouseButtonPressed(MOUSE_BUTTON_LEFT)
      physics_bodies << CreatePhysicsBodyPolygon(GetMousePosition(), GetRandomValue(20, 80).to_f, GetRandomValue(3, 8), 10)
    elsif IsMouseButtonPressed(MOUSE_BUTTON_RIGHT)
      physics_bodies << CreatePhysicsBodyCircle(GetMousePosition(), GetRandomValue(10, 45).to_f, 10)
    end

    # Destroy falling physics bodies
    bodiesCount = GetPhysicsBodiesCount()
    (bodiesCount - 1).downto(0) do |i|
      body_ptr = GetPhysicsBody(i)
      body = PhysicsBodyData.new(body_ptr)
      if body_ptr != nil && (body[:position][:y] > screenHeight*2)
        physics_bodies.delete(body_ptr)
        DestroyPhysicsBody(body)
      end
    end

    BeginDrawing()
      ClearBackground(BLACK)
      DrawFPS(screenWidth - 90, screenHeight - 30)
      # Draw created physics bodies
      bodiesCount = GetPhysicsBodiesCount()
      bodiesCount.times do |i|
        body = GetPhysicsBody(i)
        if body != nil
          vertexCount = GetPhysicsShapeVerticesCount(i)
          vertexCount.times do |j|
            # Get physics bodies shape vertices to draw lines
            # Note: GetPhysicsShapeVertex() already calculates rotation transformations
            vertexA = GetPhysicsShapeVertex(body, j)

            jj = (((j + 1) < vertexCount) ? (j + 1) : 0) # Get next vertex or first to close the shape
            vertexB = GetPhysicsShapeVertex(body, jj)

            DrawLineV(vertexA, vertexB, GREEN) # Draw a line between two vertex positions
          end
        end
      end

      DrawText("Left mouse button to create a polygon", 10, 10, 10, WHITE)
      DrawText("Right mouse button to create a circle", 10, 25, 10, WHITE)
      DrawText("Press 'R' to reset example", 10, 40, 10, WHITE)

      DrawText("Physac", logoX, logoY, 30, WHITE)
      DrawText("Powered by", logoX + 50, logoY - 7, 10, WHITE)
    EndDrawing()
  end

  ClosePhysics(); # Unitialize physics
  CloseWindow()
end
