#!/bin/sh
mkdir -p build
cd build
cmake -D CMAKE_C_FLAGS="" CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=ON -D BUILD_EXAMPLES=OFF -D GRAPHICS="GRAPHICS_API_OPENGL_21" -D CMAKE_C_COMPILER=clang ../raylib
make
cp -R raylib/libraylib.so.4.2.0 ../../lib/libraylib.so
