@echo off
setlocal enabledelayedexpansion

pushd %~dp0

cmake -B build -S . -G "Visual Studio 18 2026"
cmake --build .\build --config Release

popd
