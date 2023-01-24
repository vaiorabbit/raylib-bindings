#!/bin/sh
mkdir -p build
cd build
cmake -D CMAKE_C_FLAGS="" -D CMAKE_BUILD_TYPE=Release -D CMAKE_C_COMPILER_TARGET=aarch64-linux-gnu -D CMAKE_SYSTEM_PROCESSOR=ARM -D BUILD_SHARED_LIBS=ON -D BUILD_EXAMPLES=OFF -D PLATFORM=Desktop -D GRAPHICS="GRAPHICS_API_OPENGL_11" -D CMAKE_C_COMPILER=clang ../raylib
make
export ARCH=aarch64
cp -R raylib/libraylib.so.4.2.0 ../../lib/libraylib.${ARCH}.so
