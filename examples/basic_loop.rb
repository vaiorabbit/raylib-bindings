require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  InitWindow(800, 450, "Yet Another Ruby-raylib bindings")
  SetTargetFPS(60)

  until WindowShouldClose()
    BeginDrawing()
    ClearBackground(RAYWHITE)
    DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY)
    EndDrawing()
  end

  CloseWindow()
end
