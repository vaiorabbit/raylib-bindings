#!/bin/sh
mkdir -p build
cd build
cmake -D CMAKE_C_FLAGS=-isystem\ /usr/aarch64-linux-gnu/include -D CMAKE_BUILD_TYPE=Release -D CMAKE_C_COMPILER_TARGET=aarch64-linux-gnu -D CMAKE_SYSTEM_PROCESSOR=ARM -D BUILD_SHARED_LIBS=ON -D BUILD_EXAMPLES=OFF -D CMAKE_C_COMPILER=clang ..
make
export ARCH=aarch64
cp -R physac.so ../../lib/physac.${ARCH}.so
