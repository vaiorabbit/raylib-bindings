// $ clang -I`brew --prefix mruby`/include -I../raylib_dll/raylib/src mrb_test.c `brew --prefix mruby`/lib/libmruby.a ../lib/libraylib.a ./libmrb_raylib.a -lm -framework IOKit -framework Cocoa -framework OpenGL -o mrb_test

#include <mruby.h>
#include <mruby/compile.h>
#include <mruby/string.h>

extern void mrb_raylib_module_init(mrb_state* mrb);

int main(void)
{
    mrb_state* mrb = mrb_open();

    mrb_raylib_module_init(mrb);

    char ruby_code[] =
        /*
        "p Raylib::RAYLIB_VERSION\n"
        "color = Raylib::Color.new(255, 255, 255, 255)\n"
        "p color\n"
        "p color.r\n"
        "color.r = 128\n"
        "p color.r\n"
        "vx = Raylib::Vector3.new(1.0, 0.0, 0.0)\n"
        "vy = Raylib::Vector3.new(0.0, 1.0, 0.0)\n"
        "p vx, vy\n"
        "rc = Raylib::RayCollision.new(0, 3.0, vx, vy)\n"
        "p rc\n"
        "bi = Raylib::BoneInfo.new('Hi There!', 123)\n"
        "p bi\n"
        "p bi.name\n"
        "bi.name = 'Hello everyone!'\n"
        "p bi.name\n"
        "raylib.initwindow(1920, 1080, \"initwindow via mruby\")\n"
        "sleep(1)\n"
        "raylib.closewindow()\n"
        */
        "c = 0\n"
        "red = Raylib::Color.new(255,0,0,255)\n"
        "Raylib.InitWindow(720, 405, 'raylib/mruby')\n"
        "Raylib.SetTargetFPS(60)\n"
        "until Raylib.WindowShouldClose()\n"
        "    Raylib.BeginDrawing()\n"
        "    bg = Raylib::Color.new(c,c,c,255)\n"
        "    Raylib.ClearBackground(bg)\n"
        "    Raylib.DrawFPS(720 - 100, 16)\n"
        "    Raylib.DrawCircle(720/2, 405/2, 50.0, red)\n"
        "    Raylib.EndDrawing()\n"
        "    c = (c + 1) % 255\n"
        "end\n"
        "Raylib.CloseWindow()\n"
        ;

    mrb_load_string(mrb, ruby_code);
    mrb_print_error(mrb);
    mrb_close(mrb);

    return 0;
};
