call emcc -c mrb_raylib.c -I .\mruby\build\emscripten\include -I ..\raylib_dll\raylib\src
call emar rc libmrb_raylib.a mrb_raylib.o
