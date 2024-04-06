#!/bin/sh
export MACOSX_DEPLOYMENT_TARGET=13.0

mkdir -p build_arm64_staticlib
cd build_arm64_staticlib
cmake -D CMAKE_C_FLAGS="" -D CMAKE_BUILD_TYPE=Release -D CMAKE_OSX_ARCHITECTURES="arm64" -D BUILD_SHARED_LIBS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_C_COMPILER=clang ../raylib
make
cp raylib/libraylib.a ../../lib/libraylib.a
