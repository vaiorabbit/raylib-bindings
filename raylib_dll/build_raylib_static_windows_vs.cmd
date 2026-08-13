@echo off
setlocal enabledelayedexpansion
set CMAKE_EXE=%1
if %CMAKE_EXE% == "" (
    set CMAKE_EXE="%PROGRAMFILES%\CMake\bin\cmake"
)

pushd %~dp0
if not exist build (
    mkdir build
)

%CMAKE_EXE% -B build -S raylib -G "Visual Studio 18 2026" -D GRAPHICS=GRAPHICS_API_OPENGL_43 -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=OFF -D BUILD_EXAMPLES=OFF

pushd build
%CMAKE_EXE% --build . --config Release
%CMAKE_EXE% --install . --prefix ../../mruby/third_party/raylib
popd

popd
