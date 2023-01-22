#!/bin/sh
mkdir -p build
cd build
cmake -D CMAKE_C_FLAGS="" CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=ON -D BUILD_EXAMPLES=OFF -D CMAKE_C_COMPILER=clang ..
make
export ARCH=`uname -m`
cp -R physac.so ../../lib/physac.${ARCH}.so
