::
:: For Windows + RubyInstaller2 with DevKit(MSYS2 gcc & make) + CMake users.
:: - Use this script after "ridk enable"d. See https://github.com/oneclick/rubyinstaller2/wiki/The-ridk-tool for details.
::
:: Usage
:: > ridk enable
:: > rebuild_libs_windows.cmd  <- %PROGRAMFILES%\CMake\bin\cmake.exe will be used.
:: > rebuild_libs_windows.cmd "D:\Program Files\CMake\bin\cmake.exe" <- You can give full path to 'cmake.exe'.

@echo off
setlocal enabledelayedexpansion
set CMAKE_EXE=%1
if %CMAKE_EXE% == "" (
    set CMAKE_EXE="%PROGRAMFILES%\CMake\bin\cmake"
)

pushd %~dp0
cd ..\physac_dll
if exist build (
    rmdir /s /q build
)
call build_physac_windows.bat %CMAKE_EXE%
popd

pushd %~dp0
cd ..\raylib_dll
if exist build (
    rmdir /s /q build
)
call build_raylib_windows.bat %CMAKE_EXE%
popd

pushd %~dp0
cd ..\raygui_dll
if exist build (
    rmdir /s /q build
)
call build_raygui_windows.bat %CMAKE_EXE%
popd

