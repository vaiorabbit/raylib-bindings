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
        "color = Raylib::Color.new\n"
        "p color\n"
        ;

    mrb_load_string(mrb, ruby_code);
    mrb_print_error(mrb);
    mrb_close(mrb);

    return 0;
};
