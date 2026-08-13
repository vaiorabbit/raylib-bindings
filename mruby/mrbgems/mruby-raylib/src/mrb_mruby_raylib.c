// Copyright (c) 2023-2026 vaiorabbit <http://twitter.com/vaiorabbit>

#include <mruby.h>

extern void mrb_raylib_module_init(mrb_state* mrb);
/* extern void mrb_raygui_module_init(struct RClass* mRaylib, mrb_state* mrb); */

void mrb_mruby_raylib_gem_init(mrb_state* mrb)
{
	mrb_raylib_module_init(mrb);

	/* extern struct RClass* mRaylib; */
	/* mrb_raygui_module_init(mRaylib, mrb); */
}

void mrb_mruby_raylib_gem_final(mrb_state* mrb)
{
}
