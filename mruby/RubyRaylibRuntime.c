#include <mruby.h>
#include <mruby/compile.h>
#include <mruby/string.h>

extern void mrb_raylib_module_init(mrb_state* mrb);

int main(int argc, char** argv)
{
    if (argc < 2) {
        fprintf(stderr, "RubyRaylibRuntime [ruby_code.rb]\n");
        return -1;
    }

    FILE* fp = fopen(argv[1], "r");
    if (!fp) {
        fprintf(stderr, "RubyRaylibRuntime [ruby_code.rb]\n");
        return -1;
    }

    mrb_state* mrb = mrb_open();

    mrb_raylib_module_init(mrb);

    {
        int arena = mrb_gc_arena_save(mrb);
        mrbc_context* cxt = mrbc_context_new(mrb);
        mrbc_filename(mrb, cxt, argv[1]);
        mrb_load_file_cxt(mrb, fp, cxt);
        mrbc_context_free(mrb, cxt);
        fclose(fp);

        if (mrb->exc) { // Exception
            mrb_print_error(mrb);
            mrb->exc = NULL;
        }
        mrb_gc_arena_restore(mrb, arena);
    }

    mrb_close(mrb);

    return 0;
};
