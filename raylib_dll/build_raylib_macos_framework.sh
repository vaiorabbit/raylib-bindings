#!/bin/sh
export MACOSX_DEPLOYMENT_TARGET=14.0

#mkdir -p build_x86_64
#cd build_x86_64
#cmake -D CMAKE_C_FLAGS="" -D CMAKE_BUILD_TYPE=Release -D CMAKE_OSX_ARCHITECTURES="x86_64" -D BUILD_SHARED_LIBS=ON -D BUILD_EXAMPLES=OFF -D CMAKE_C_COMPILER=clang ../raylib
#make
#cp raylib/libraylib.dylib ../../lib/libraylib.x86_64.dylib
#
#cd ..

mkdir -p build_arm64
cd build_arm64
cmake -D CMAKE_C_FLAGS="" -D CMAKE_BUILD_TYPE=Release -D CMAKE_OSX_ARCHITECTURES="arm64" -D BUILD_SHARED_LIBS=ON -D MACOS_FRAMEWORK=ON -D BUILD_EXAMPLES=OFF -D CMAKE_C_COMPILER=clang ../raylib
make
cp raylib/libraylib.dylib ../../lib/libraylib.arm64.dylib
