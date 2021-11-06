::
:: For Windows + RubyInstaller2 with DevKit(MSYS2 gcc & make) + CMake users.
:: - Use this script after "ridk enable"d. See https://github.com/oneclick/rubyinstaller2/wiki/The-ridk-tool for details.
::
:: Usage
:: > ridk enable
:: > build_raylib_windows.bat  <- %PROGRAMFILES%\CMake\bin\cmake.exe will be used.
:: > build_raylib_windows.bat "D:\Program Files\CMake\bin\cmake.exe" <- You can give full path to 'cmake.exe'.

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
cd build
%CMAKE_EXE% -G "MSYS Makefiles" -D GRAPHICS=GRAPHICS_API_OPENGL_43 -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=ON -D BUILD_EXAMPLES=OFF -D CMAKE_C_COMPILER=gcc ../raylib
make
copy raylib\libraylib.dll ..\..\lib
popd
