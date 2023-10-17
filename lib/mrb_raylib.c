#include <mruby.h>
/*
    $ clang -c -I`brew --prefix mruby`/include -I../raylib_dll/raylib/src mrb_raylib.c `brew --prefix mruby`/lib/libmruby.a ../lib/libraylib.a -lm -framework IOKit -framework Cocoa -framework OpenGL -o mrb_raylib.o
    $ ar rc libmrb_raylib.a mrb_raylib.o
*/
#include <mruby/class.h>
#include <mruby/compile.h>
#include <mruby/data.h>
#include <mruby/string.h>

#include <raylib.h>

struct RClass* mRaylib;


void mrb_raylib_module_module_init(mrb_state* mrb)
{

    // Define/Macro

    mrb_define_const(mrb, mRaylib, "RAYLIB_VERSION_MAJOR", mrb_int_value(mrb, 4));
    mrb_define_const(mrb, mRaylib, "RAYLIB_VERSION_MINOR", mrb_int_value(mrb, 6));
    mrb_define_const(mrb, mRaylib, "RAYLIB_VERSION_PATCH", mrb_int_value(mrb, 0));
    mrb_define_const(mrb, mRaylib, "RAYLIB_VERSION", mrb_str_new_cstr_frozen(mrb, "4.6-dev"));

}
