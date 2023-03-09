# coding: utf-8
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  GLSL_VERSION = 330

  screenWidth = 800
  screenHeight = 450

  SetConfigFlags(FLAG_WINDOW_RESIZABLE)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - raymarching shapes")

  camera = Camera.new
  camera[:position] = Vector3.create(2.5, 2.5, 3.0)
  camera[:target] = Vector3.create(0.0, 0.0, 0.7)
  camera[:up] = Vector3.create(0.0, 1.0, 0.0)
  camera[:fovy] = 65.0

  # Load raymarching shader
  # NOTE: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
  shader = LoadShader(nil, RAYLIB_SHADERS_PATH + "resources/shaders/glsl#{GLSL_VERSION}/raymarching.fs")

  # Get shader locations for required uniforms
  viewEyeLoc = GetShaderLocation(shader, "viewEye")
  viewCenterLoc = GetShaderLocation(shader, "viewCenter")
  runTimeLoc = GetShaderLocation(shader, "runTime")
  resolutionLoc = GetShaderLocation(shader, "resolution")

  resolution = [screenWidth.to_f, screenHeight.to_f]
  SetShaderValue(shader, resolutionLoc, resolution.pack('f2'), SHADER_UNIFORM_VEC2)

  runTime = 0.0

  SetTargetFPS(60)

  until WindowShouldClose()

    UpdateCamera(camera.pointer, CAMERA_FREE)

    cameraPos = [camera[:position][:x], camera[:position][:y], camera[:position][:z]]
    cameraTarget = [camera[:target][:x], camera[:target][:y], camera[:target][:z]]

    deltaTime = GetFrameTime()
    runTime += deltaTime

    # Set shader required uniform values
    SetShaderValue(shader, viewEyeLoc, cameraPos.pack('f3'), SHADER_UNIFORM_VEC3)
    SetShaderValue(shader, viewCenterLoc, cameraTarget.pack('f3'), SHADER_UNIFORM_VEC3)
    SetShaderValue(shader, runTimeLoc, [runTime].pack('f'), SHADER_UNIFORM_FLOAT)

    # Check if screen is resized
    if IsWindowResized()
      screenWidth = GetScreenWidth()
      screenHeight = GetScreenHeight()
      resolution = [screenWidth.to_f, screenHeight.to_f]
      SetShaderValue(shader, resolutionLoc, resolution.pack('f2'), SHADER_UNIFORM_VEC2)
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)

      # We only draw a white full-screen rectangle,
      # frame is generated in shader using raymarching
      BeginShaderMode(shader)
        DrawRectangle(0, 0, screenWidth, screenHeight, WHITE)
      EndShaderMode()

      DrawText("(c) Raymarching shader by Iñigo Quilez. MIT License.", screenWidth - 280, screenHeight - 20, 10, BLACK)
    EndDrawing()
  end

  UnloadShader(shader)
  CloseWindow()
end
