@echo off
setlocal enabledelayedexpansion

pushd %~dp0

call emcmake cmake -B build_wasm -S . -D PLATFORM=Web
call cmake --build .\build_wasm --config Release
call cmake --install .\build_wasm --prefix ../mruby/third_party/physac/wasm

popd
