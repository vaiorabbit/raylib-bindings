require_relative 'util/setup_dll'

$textureGrid = nil
$cameraPlayer1 = nil
$cameraPlayer2 = nil

def DrawScene()
  count = 5
  spacing = 4.0

  # Grid of cube trees on a plane to make a "world"
  DrawPlane(Vector3.create(0, 0, 0), Vector2.create(50, 50), BEIGE) # Simple world plane

  range_x = -count*spacing .. count*spacing
  range_z = -count*spacing .. count*spacing

  range_x.step(spacing) do |x|
    range_z.step(spacing) do |z|
      DrawCube(Vector3.create(x, 1.5, z), 1, 1, 1, LIME)
      DrawCube(Vector3.create(x, 0.5, z), 0.25, 1, 0.25, BROWN)
    end
  end

  # Draw a cube at each player's position
  DrawCube($cameraPlayer1.position, 1, 1, 1, RED)
  DrawCube($cameraPlayer2.position, 1, 1, 1, BLUE)
end

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - split screen")

  # Setup player 1 camera and screen
  $cameraPlayer1 = Camera.new
                     .with_fovy(45.0)
                     .with_up(0.0, 1.0, 0.0)
                     .with_target(0.0, 1.0, 0.0)
                     .with_position(-3.0, 1.0, 0.0)
                     .with_projection(CAMERA_PERSPECTIVE)

  screenPlayer1 = LoadRenderTexture(screenWidth/2, screenHeight)

  # Setup player two camera and screen

  $cameraPlayer2 = Camera.new
                     .with_fovy(45.0)
                     .with_up(0.0, 1.0, 0.0)
                     .with_target(0.0, 3.0, 0.0)
                     .with_position(-3.0, 3.0, 0.0)
                     .with_projection(CAMERA_PERSPECTIVE)

  screenPlayer2 = LoadRenderTexture(screenWidth/2, screenHeight)

  # Build a flipped rectangle the size of the split view to use for drawing later
  splitScreenRect = Rectangle.create(0.0, 0.0, screenPlayer1[:texture][:width].to_f, -screenPlayer1[:texture][:height].to_f)

  SetTargetFPS(60) # Set our game to run at 60 frames-per-second

  until WindowShouldClose()
    # Update
    #----------------------------------------------------------------------------------
    # If anyone moves this frame, how far will they move based on the time since the last frame
    # this moves thigns at 10 world units per second, regardless of the actual FPS
    offsetThisFrame = 10.0 * GetFrameTime()

    # Move Player1 forward and backwards (no turning)
    if IsKeyDown(KEY_W)
      $cameraPlayer1.position.z += offsetThisFrame
      $cameraPlayer1.target.z += offsetThisFrame
    elsif IsKeyDown(KEY_S)
      $cameraPlayer1.position.z -= offsetThisFrame
      $cameraPlayer1.target.z -= offsetThisFrame
    end

    # Move Player2 forward and backwards (no turning)
    if IsKeyDown(KEY_UP)
      $cameraPlayer2.position.x += offsetThisFrame
      $cameraPlayer2.target.x += offsetThisFrame
    elsif IsKeyDown(KEY_DOWN)
      $cameraPlayer2.position.x -= offsetThisFrame
      $cameraPlayer2.target.x -= offsetThisFrame
    end

    #----------------------------------------------------------------------------------

    # Draw
    #----------------------------------------------------------------------------------
    # Draw Player1 view to the render texture
    BeginTextureMode(screenPlayer1)
      ClearBackground(SKYBLUE)
      BeginMode3D($cameraPlayer1)
        DrawScene()
      EndMode3D()
      DrawText("PLAYER1 W/S to move", 10, 10, 20, RED)
    EndTextureMode()

    # Draw Player2 view to the render texture
    BeginTextureMode(screenPlayer2)
      ClearBackground(SKYBLUE)
      BeginMode3D($cameraPlayer2)
        DrawScene()
      EndMode3D()
      DrawText("PLAYER2 UP/DOWN to move", 10, 10, 20, RED)
    EndTextureMode()

    # Draw both views render textures to the screen side by side
    BeginDrawing()
      ClearBackground(BLACK)
      DrawTextureRec(screenPlayer1[:texture], splitScreenRect, Vector2.create(0, 0), WHITE)
      DrawTextureRec(screenPlayer2[:texture], splitScreenRect, Vector2.create(screenWidth/2.0, 0), WHITE)
    EndDrawing()
  end

  UnloadRenderTexture(screenPlayer1)
  UnloadRenderTexture(screenPlayer2)

  CloseWindow()
end
