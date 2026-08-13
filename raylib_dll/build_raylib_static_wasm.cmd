@echo off
setlocal enabledelayedexpansion

pushd %~dp0
if not exist build_wasm (
    mkdir build_wasm
)

call emcmake cmake -B build_wasm -S raylib -D PLATFORM=Web -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=OFF -D BUILD_EXAMPLES=OFF

pushd build_wasm
call cmake --build . --config Release
call cmake --install . --prefix ../../mruby/third_party/raylib/wasm
popd

popd
