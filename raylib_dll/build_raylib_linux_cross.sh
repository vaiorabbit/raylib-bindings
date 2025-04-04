#!/bin/sh
mkdir -p build
cd build
cmake -D CMAKE_C_FLAGS=-isystem\ /usr/aarch64-linux-gnu/include -D CMAKE_BUILD_TYPE=Release -D CMAKE_C_COMPILER_TARGET=aarch64-linux-gnu -D CMAKE_SYSTEM_PROCESSOR=aarch64 -D CMAKE_LIBRARY_PATH="/usr/aarch64-linux-gnu/lib;/lib/aarch64-linux-gnu" -D BUILD_SHARED_LIBS=ON -D BUILD_EXAMPLES=OFF -D PLATFORM=Desktop -D GRAPHICS="GRAPHICS_API_OPENGL_21" -D CMAKE_C_COMPILER=clang ../raylib
make
export ARCH=aarch64
cp raylib/libraylib.so ../../lib/libraylib.${ARCH}.so
