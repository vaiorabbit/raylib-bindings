require_relative 'util/setup_dll'

if __FILE__ == $PROGRAM_NAME
  screen_width = 800
  screen_height = 450
  InitWindow(screen_width, screen_height, 'Particles Fireworks')
  SetTargetFPS(60)

  colors = [RED, ORANGE, GOLD, YELLOW, LIME, SKYBLUE, BLUE, PURPLE]

  gravity = 0.25
  default_count = 120
  speed_min = 2.0
  speed_max = 6.0

  fireworks = []

  spawn = lambda do |x, y, count|
    color = colors[GetRandomValue(0, colors.length - 1)]
    particles = []
    count.times do
      angle = (GetRandomValue(0, 360) * Math::PI) / 180.0
      speed = speed_min + (GetRandomValue(0, 1000) / 1000.0) * (speed_max - speed_min)
      vx = Math.cos(angle) * speed
      vy = Math.sin(angle) * speed
      life = GetRandomValue(35, 70)
      particles << { x: x.to_f, y: y.to_f, vx: vx, vy: vy, life: life, max: life, color: color }
    end
    fireworks << particles
  end

  until WindowShouldClose()
    if IsMouseButtonPressed(MOUSE_BUTTON_LEFT)
      m = GetMousePosition()
      spawn.call(m.x, m.y, default_count)
    end

    if IsKeyPressed(KEY_SPACE)
      spawn.call(GetRandomValue(100, screen_width - 100), GetRandomValue(100, screen_height - 200), default_count)
    end

    if IsKeyPressed(KEY_ONE)
      default_count = [default_count - 40, 40].max
    elsif IsKeyPressed(KEY_TWO)
      default_count = [default_count + 40, 400].min
    end

    fireworks.clear if IsKeyPressed(KEY_C)

    BeginDrawing()
    ClearBackground(BLACK)

    DrawText("Left Click: spawn  |  SPACE: random  |  C: clear  |  1/2: count #{default_count}", 12, 12, 20, RAYWHITE)

    fireworks.each do |particles|
      i = 0
      while i < particles.length
        p = particles[i]
        p[:vy] += gravity
        p[:x] += p[:vx]
        p[:y] += p[:vy]
        p[:life] -= 1

        alpha = (p[:life].to_f / p[:max])
        alpha = 0.0 if alpha < 0.0
        radius = 2.0 + 4.0 * alpha

        col = Color.from_u8(p[:color].r, p[:color].g, p[:color].b, (alpha * 255).to_i)

        DrawCircle(p[:x].to_i, p[:y].to_i, radius, col)
        DrawCircle(p[:x].to_i, p[:y].to_i, radius * 0.6, col)

        if p[:life] <= 0 || p[:y] > screen_height + 50
          particles.delete_at(i)
        else
          i += 1
        end
      end
    end

    i = 0
    while i < fireworks.length
      if fireworks[i].empty?
        fireworks.delete_at(i)
      else
        i += 1
      end
    end
    EndDrawing()
  end

  CloseWindow()
end
