require_relative 'util/setup_dll'
require_relative 'util/resource_path'

# This is the maximum amount of elements (quads) per batch
# NOTE: This value is defined in [rlgl] module and can be changed there
MAX_BATCH_ELEMENTS = 8192

Bunny = Struct.new(:position, :speed, :color, keyword_init: true)

if __FILE__ == $PROGRAM_NAME

  screenWidth = 800
  screenHeight = 450

  MAX_BUNNIES = 50000

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - bunnymark")

  # Load bunny texture
  texBunny = LoadTexture(RAYLIB_TEXTURE_PATH + "resources/wabbit_alpha.png")

  bunnies = []

  SetTargetFPS(60)

  until WindowShouldClose()
    if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
      # Create more bunnies
      100.times do
        if bunnies.length < MAX_BUNNIES
          bunnies << Bunny.new(position: GetMousePosition(), speed: Vector2.create(GetRandomValue(-250, 250)/60.0, GetRandomValue(-250, 250)/60.0), color: Color.from_u8(GetRandomValue(50, 240), GetRandomValue(80, 240), GetRandomValue(100, 240), 255))
        end
      end
    end

    # Update bunnies
    bunnies.each do |bunny|
      bunny.position.x += bunny.speed.x
      bunny.position.y += bunny.speed.y

      if ((bunny.position.x + texBunny.width/2) > GetScreenWidth()) || ((bunny.position.x + texBunny.width/2) < 0)
        bunny.speed.x *= -1
      end

      if ((bunny.position.y + texBunny.height/2) > GetScreenHeight()) || ((bunny.position.y + texBunny.height/2 - 40) < 0)
        bunny.speed.y *= -1
      end
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      bunnies.each do |bunny|
        # NOTE: When internal batch buffer limit is reached (MAX_BATCH_ELEMENTS),
        # a draw call is launched and buffer starts being filled again;
        # before issuing a draw call, updated vertex data from internal CPU buffer is send to GPU...
        # Process of sending data is costly and it could happen that GPU data has not been completely
        # processed for drawing while new data is tried to be sent (updating current in-use buffers)
        # it could generates a stall and consequently a frame drop, limiting the number of drawn bunnies
        DrawTexture(texBunny, bunny.position.x, bunny.position.y, bunny.color)
      end

      DrawRectangle(0, 0, screenWidth, 40, BLACK)
      DrawText(TextFormat("bunnies: %i", :int, bunnies.length), 120, 10, 20, GREEN)
      DrawText(TextFormat("batched draw calls: %i", :int, 1 + bunnies.length/MAX_BATCH_ELEMENTS), 320, 10, 20, MAROON)

      DrawFPS(10, 10)
    EndDrawing()
  end

  UnloadTexture(texBunny)
  CloseWindow()
end
