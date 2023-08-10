require_relative 'util/setup_dll'
require_relative 'util/resource_path'

# [NOTE] This sample requires:
# - Windows OS
# - OpenGL 4.3 capable GPU
# - libraylib.dll built with 'GRAPHICS=GRAPHICS_API_OPENGL_43'

if __FILE__ == $PROGRAM_NAME

  # IMPORTANT: This must match gol*.glsl GOL_WIDTH constant.
  # This must be a multiple of 16 (check golLogic compute dispatch).
  GOL_WIDTH = 768

  # Maximum amount of queued draw commands (squares draw from mouse down events).
  MAX_BUFFERED_TRANSFERTS = 48

  # Game Of Life Update Command
  class GolUpdateCmd < FFI::Struct
    layout(
      :x, :uint,         # x coordinate of the gol command
      :y, :uint,         # y coordinate of the gol command
      :w, :uint,         # width of the filled zone
      :enabled, :uint,   # whether to enable or disable zone
    )
  end

  # Game Of Life Update Commands SSBO
  class GolUpdateSSBO < FFI::Struct
    layout(
      :count, :uint,
      :commands, [GolUpdateCmd, MAX_BUFFERED_TRANSFERTS],
    )
  end

  InitWindow(GOL_WIDTH, GOL_WIDTH, "Yet Another Ruby-raylib bindings - compute shader - game of life")

  resolution = Vector2.create(GOL_WIDTH, GOL_WIDTH)
  brushSize = 8

  # Game of Life logic compute shader
  golLogicCode = LoadFileText(RAYLIB_OTHERS_PATH + "resources/shaders/glsl430/gol.glsl")
  golLogicShader = rlCompileShader(golLogicCode, RL_COMPUTE_SHADER)
  golLogicProgram = rlLoadComputeShaderProgram(golLogicShader)
  UnloadFileText(golLogicCode)

  # Game of Life logic compute shader
  golRenderShader = LoadShader(nil, RAYLIB_OTHERS_PATH + "resources/shaders/glsl430/gol_render.glsl")
  resUniformLoc = GetShaderLocation(golRenderShader, "resolution")

  # Game of Life transfert shader
  golTransfertCode = LoadFileText( RAYLIB_OTHERS_PATH + "resources/shaders/glsl430/gol_transfert.glsl")
  golTransfertShader = rlCompileShader(golTransfertCode, RL_COMPUTE_SHADER)
  golTransfertProgram = rlLoadComputeShaderProgram(golTransfertShader)
  UnloadFileText(golTransfertCode)

  # SSBOs
  ssboA = rlLoadShaderBuffer(GOL_WIDTH*GOL_WIDTH*FFI::type_size(:uint), nil, RL_DYNAMIC_COPY)
  ssboB = rlLoadShaderBuffer(GOL_WIDTH*GOL_WIDTH*FFI::type_size(:uint), nil, RL_DYNAMIC_COPY)

  transfertBuffer = GolUpdateSSBO.new
  transfertBuffer.count = 0

  transfertSSBO = rlLoadShaderBuffer(GolUpdateSSBO.size, nil, RL_DYNAMIC_COPY)

  # Create a white texture of the size of the window to update 
  # each pixel of the window using the fragment shader
  whiteImage = GenImageColor(GOL_WIDTH, GOL_WIDTH, WHITE)
  whiteTex = LoadTextureFromImage(whiteImage)
  UnloadImage(whiteImage)

  until WindowShouldClose()

    brushSize += GetMouseWheelMove().to_f

    if (IsMouseButtonDown(MOUSE_BUTTON_LEFT) || IsMouseButtonDown(MOUSE_BUTTON_RIGHT)) && (transfertBuffer.count < MAX_BUFFERED_TRANSFERTS)
      # Buffer a new command
      transfertBuffer.commands[transfertBuffer.count].x = GetMouseX() - brushSize/2
      transfertBuffer.commands[transfertBuffer.count].y = GetMouseY() - brushSize/2
      transfertBuffer.commands[transfertBuffer.count].w = brushSize
      transfertBuffer.commands[transfertBuffer.count].enabled = IsMouseButtonDown(MOUSE_BUTTON_LEFT) ? 1 : 0
      transfertBuffer.count += 1
    elsif transfertBuffer.count > 0
      # Process transfert buffer

      # Send SSBO buffer to GPU
      rlUpdateShaderBuffer(transfertSSBO, transfertBuffer, GolUpdateSSBO.size, 0)

      # Process ssbo command
      rlEnableShader(golTransfertProgram)
      rlBindShaderBuffer(ssboA, 1)
      rlBindShaderBuffer(transfertSSBO, 3)
      rlComputeShaderDispatch(transfertBuffer.count, 1, 1) # each GPU unit will process a command
      rlDisableShader()

      transfertBuffer.count = 0
    else # elsif IsKeyDown(KEY_SPACE)
      # Process game of life logic
      rlEnableShader(golLogicProgram)
      rlBindShaderBuffer(ssboA, 1)
      rlBindShaderBuffer(ssboB, 2)
      rlComputeShaderDispatch(GOL_WIDTH/16, GOL_WIDTH/16, 1)
      rlDisableShader()

      # ssboA <-> ssboB
      ssboA, ssboB = ssboB, ssboA
    end

    rlBindShaderBuffer(ssboA, 1)
    SetShaderValue(golRenderShader, resUniformLoc, resolution, SHADER_UNIFORM_VEC2)

    BeginDrawing()

      ClearBackground(BLANK)

      BeginShaderMode(golRenderShader)
        DrawTexture(whiteTex, 0, 0, WHITE)
      EndShaderMode()

      DrawRectangleLines(GetMouseX() - brushSize/2, GetMouseY() - brushSize/2, brushSize, brushSize, RED)

      DrawText("Use Mouse wheel to increase/decrease brush size", 10, 10, 20, WHITE)
      DrawFPS(GetScreenWidth() - 100, 10)

    EndDrawing()
  end

  # Unload shader buffers objects.
  rlUnloadShaderBuffer(ssboA)
  rlUnloadShaderBuffer(ssboB)
  rlUnloadShaderBuffer(transfertSSBO)

  # Unload compute shader programs
  rlUnloadShaderProgram(golTransfertProgram)
  rlUnloadShaderProgram(golLogicProgram)

  UnloadTexture(whiteTex)       # Unload white texture
  UnloadShader(golRenderShader) # Unload rendering fragment shader

  CloseWindow()

end
