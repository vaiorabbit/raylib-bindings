all:
	clang -c -I`brew --prefix mruby`/include -I../raylib_dll/raylib/src mrb_raylib.c `brew --prefix mruby`/lib/libmruby.a ../lib/libraylib.a -lm -framework IOKit -framework Cocoa -framework OpenGL -o mrb_raylib.o
	ar rc libmrb_raylib.a mrb_raylib.o
	clang -I`brew --prefix mruby`/include -I../raylib_dll/raylib/src mrb_test.c `brew --prefix mruby`/lib/libmruby.a ../lib/libraylib.a ./libmrb_raylib.a -lm -framework IOKit -framework Cocoa -framework OpenGL -o mrb_test
clean:
	rm libmrb_raylib.a mrb_raylib.o mrb_test
