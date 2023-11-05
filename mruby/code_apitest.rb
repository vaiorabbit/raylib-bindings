p Raylib::RAYLIB_VERSION
color = Raylib::Color.new(255, 255, 255, 255)
p color
p color.r
color.r = 128
p color.r
vx = Raylib::Vector3.new(1.0, 0.0, 0.0)
vy = Raylib::Vector3.new(0.0, 1.0, 0.0)
p vx, vy
rc = Raylib::RayCollision.new(0, 3.0, vx, vy)
p rc
bi = Raylib::BoneInfo.new('Hi There!', 123)
p bi
p bi.name
bi.name = 'Hello everyone!'
p bi.name
Raylib.InitWindow(1920, 1080, "initwindow via mruby")
sleep(1)
Raylib.CloseWindow()
