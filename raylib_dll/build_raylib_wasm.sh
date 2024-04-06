#!/bin/sh

mkdir -p build_wasm
cd raylib
emcmake cmake -S . -B ../build_wasm -D PLATFORM=Web -D CMAKE_BUILD_TYPE=Release -D BUILD_EXAMPLES=OFF
cmake --build ../build_wasm
cd ../build_wasm
cp raylib/libraylib.a ../../lib/libraylib.a
