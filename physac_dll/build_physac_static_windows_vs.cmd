@echo off
setlocal enabledelayedexpansion

pushd %~dp0

cmake -B build -S . -G "Visual Studio 18 2026" -D BUILD_SHARED_LIBS=OFF
cmake --build .\build --config Release
cmake --install .\build --prefix ../mruby/third_party/physac

popd
