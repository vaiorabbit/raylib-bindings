c = 0
Raylib.InitWindow(720, 405, 'raylib/mruby')
Raylib.SetTargetFPS(60)
until Raylib.WindowShouldClose()
    Raylib.BeginDrawing()
    bg = Raylib::Color.new(c,c,c,255)
    Raylib.ClearBackground(bg)
    Raylib.DrawFPS(720 - 100, 16)
    Raylib.EndDrawing()
    c = (c + 1) % 255
    p [Raylib::Vector3.size, bg.class.size]
end
Raylib.CloseWindow()
