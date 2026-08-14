@echo off
setlocal enabledelayedexpansion

pushd %~dp0

emcmake cmake -B build -S . -G "NMake Makefiles"
cmake --build .\build --config Release

popd
