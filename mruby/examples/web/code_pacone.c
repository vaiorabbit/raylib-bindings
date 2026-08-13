#include <mruby.h>
#include <mruby/irep.h>

#include "code_pacone.h"

int main(void)
{
    mrb_state* mrb = mrb_open();
    if (!mrb) {
        return 1;
    }

    mrb_load_irep(mrb, code_pacone);
    mrb_print_error(mrb);
    mrb_close(mrb);

    return 0;
};
