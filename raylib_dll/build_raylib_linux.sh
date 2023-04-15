#!/bin/sh
mkdir -p build
cd build
cmake -D CMAKE_C_FLAGS="" -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=ON -D BUILD_EXAMPLES=OFF -D PLATFORM=Desktop -D GRAPHICS="GRAPHICS_API_OPENGL_21" -D CMAKE_C_COMPILER=clang ../raylib
make
export ARCH=`uname -m`
cp raylib/libraylib.so ../../lib/libraylib.${ARCH}.so
