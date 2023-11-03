mkdir test
call emcc -o test\mrb_test.html mrb_test.c  -Os -s USE_GLFW=3 -s ASSERTIONS=1 -s WASM=1 -s ASYNCIFY -s ALLOW_MEMORY_GROWTH=1 --no-heap-copy --shell-file ..\raylib_dll\raylib\src\minshell.html -I .\mruby\build\emscripten\include -L . -L .\mruby\build\emscripten\lib -L ..\raylib_dll\build\raylib -lmrb_raylib -lmruby -lraylib
