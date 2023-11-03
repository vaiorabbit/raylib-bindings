#include <mruby.h>
#include <mruby/compile.h>
#include <mruby/string.h>

extern void mrb_raylib_module_init(mrb_state* mrb);

int main(void)
{
    mrb_state* mrb = mrb_open();

    mrb_raylib_module_init(mrb);

    char ruby_code[] =
#include "code_pacone.h"
// #include "code_apitest.h"
// #include "code_mainloop.h"
        ;

    mrb_load_string(mrb, ruby_code);
    mrb_print_error(mrb);
    mrb_close(mrb);

    return 0;
};
