#include <mruby.h>
#include <mruby/compile.h>
#include <mruby/string.h>
#include <stdio.h>

int main(int argc, char** argv)
{
	const char* script_path = (argc > 1) ? argv[1] : "../code_pacone.rb";
	mrb_state* mrb;
	mrb_value receiver;
	mrb_sym app_setup;
	mrb_sym app_update;
	mrb_sym app_cleanup;
	FILE* fp;
	mrbc_context* context;
	int exit_code = 0;

	mrb = mrb_open();
	if (!mrb) {
		fprintf(stderr, "failed to initialize mruby\n");
		return 1;
	}

	fp = fopen(script_path, "rb");
	if (!fp) {
		fprintf(stderr, "failed to open script: %s\n", script_path);
		mrb_close(mrb);
		return 1;
	}

	context = mrbc_context_new(mrb);
	if (!context) {
		fprintf(stderr, "failed to create mruby compiler context\n");
		fclose(fp);
		mrb_close(mrb);
		return 1;
	}
	mrbc_filename(mrb, context, script_path);
	mrb_load_file_cxt(mrb, fp, context);

	if (mrb->exc) {
		mrb_print_error(mrb);
		exit_code = 1;
		goto cleanup;
	}

	// Example 1: Call global functions
	{
		receiver = mrb_top_self(mrb);
		app_setup = mrb_intern_cstr(mrb, "app_setup");
		app_update = mrb_intern_cstr(mrb, "app_update");
		app_cleanup = mrb_intern_cstr(mrb, "app_cleanup");

		mrb_funcall_id(mrb, receiver, app_setup, 0);
		if (mrb->exc) {
			mrb_print_error(mrb);
			exit_code = 1;
			goto cleanup;
		}

		for (;;) {
			mrb_value result = mrb_funcall_id(mrb, receiver, app_update, 0);
			if (mrb->exc) {
				mrb_print_error(mrb);
				exit_code = 1;
				goto cleanup;
			}
			if (!mrb_test(result)) {
				break;
			}
		}

		mrb_funcall_id(mrb, receiver, app_cleanup, 0);
		if (mrb->exc) {
			mrb_print_error(mrb);
			exit_code = 1;
		}
	}

	mrb_full_gc(mrb);

	// Example 2: Create application instance and call its methods
	int application_registered = 0;
	mrb_value application;
	{
		mrb_sym method_setup;
		mrb_sym method_update;
		mrb_sym method_cleanup;
		struct RClass* application_class;

		application_class = mrb_class_get(mrb, "Application");
		if (mrb->exc) {
			mrb_print_error(mrb);
			exit_code = 1;
			goto cleanup;
		}
		application = mrb_obj_new(mrb, application_class, 0, NULL);
		if (mrb->exc) {
			mrb_print_error(mrb);
			exit_code = 1;
			goto cleanup;
		}
		mrb_gc_register(mrb, application);
		application_registered = 1;
		method_setup = mrb_intern_cstr(mrb, "setup");
		method_update = mrb_intern_cstr(mrb, "update");
		method_cleanup = mrb_intern_cstr(mrb, "cleanup");

		mrb_funcall_id(mrb, application, method_setup, 0);
		if (mrb->exc) {
			mrb_print_error(mrb);
			exit_code = 1;
			goto cleanup;
		}

		for (;;) {
			mrb_value result = mrb_funcall_id(mrb, application, method_update, 0);
			if (mrb->exc) {
				mrb_print_error(mrb);
				exit_code = 1;
				goto cleanup;
			}
			if (!mrb_test(result)) {
				break;
			}
		}

		mrb_funcall_id(mrb, application, method_cleanup, 0);
		if (mrb->exc) {
			mrb_print_error(mrb);
			exit_code = 1;
		}
	}

cleanup:
	fclose(fp);
	if (application_registered) {
		mrb_gc_unregister(mrb, application);
	}
	mrbc_context_free(mrb, context);
	mrb_close(mrb);
	return exit_code;
};
