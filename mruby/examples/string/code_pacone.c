#include <mruby.h>
#include <mruby/compile.h>
#include <mruby/string.h>
#include <stdio.h>
#include <stdlib.h>

static char* read_text_file(const char* path, size_t* out_size)
{
    FILE* fp = fopen(path, "rb");
    char* buf;
    long file_size;
    size_t read_size;

    if (!fp) {
        return NULL;
    }

    if (fseek(fp, 0, SEEK_END) != 0) {
        fclose(fp);
        return NULL;
    }

    file_size = ftell(fp);
    if (file_size < 0) {
        fclose(fp);
        return NULL;
    }

    if (fseek(fp, 0, SEEK_SET) != 0) {
        fclose(fp);
        return NULL;
    }

    buf = (char*)malloc((size_t)file_size + 1);
    if (!buf) {
        fclose(fp);
        return NULL;
    }

    read_size = fread(buf, 1, (size_t)file_size, fp);
    fclose(fp);

    if (read_size != (size_t)file_size) {
        free(buf);
        return NULL;
    }

    buf[file_size] = '\0';
    if (out_size) {
        *out_size = (size_t)file_size;
    }

    return buf;
}

int main(int argc, char** argv)
{
    const char* script_path = (argc > 1) ? argv[1] : "./code_pacone.rb";
    size_t ruby_code_size = 0;
    char* ruby_code;
    mrb_state* mrb = mrb_open();

    if (!mrb) {
        fprintf(stderr, "failed to initialize mruby\n");
        return 1;
    }

    ruby_code = read_text_file(script_path, &ruby_code_size);
    if (!ruby_code) {
        fprintf(stderr, "failed to read script: %s\n", script_path);
        mrb_close(mrb);
        return 1;
    }

    mrb_load_nstring(mrb, ruby_code, ruby_code_size);
    mrb_print_error(mrb);
    free(ruby_code);
    mrb_close(mrb);

    return 0;
};
