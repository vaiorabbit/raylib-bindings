@echo off
setlocal EnableExtensions

if /I "%~1"=="-h" goto :help
if /I "%~1"=="--help" goto :help

set BUILD_FOR_WASM=1

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "MRUBY_ROOT=%%~fI"
set "THIRD_PARTY_MRUBY=%MRUBY_ROOT%\third_party\mruby"
set "THIRD_PARTY_RAYLIB=%MRUBY_ROOT%\third_party\raylib\wasm"
set "RAYLIB_ROOT=%MRUBY_ROOT%\third_party\raylib\wasm"
set "VS_CONFIG=%MRUBY_ROOT%\third_party\emscripten.rb"
set "MRUBY_BUILD_DIR=%MRUBY_ROOT%\bin_web"
if "%RAKE_CMD%"=="" set "RAKE_CMD=rake"

set "MRUBY_BUILD_DIR_RB=%MRUBY_BUILD_DIR:\=/%"
set "VS_CONFIG_RB=%VS_CONFIG:\=/%"

if not exist "%THIRD_PARTY_MRUBY%\Rakefile" (
  echo [ERROR] mruby submodule is not initialized: "%THIRD_PARTY_MRUBY%"
  echo         Run: git submodule update --init --recursive
  exit /b 1
)

if not exist "%VS_CONFIG%" (
  echo [ERROR] Config not found: "%VS_CONFIG%"
  exit /b 1
)

if not exist "%THIRD_PARTY_RAYLIB%\include\raylib.h" (
  echo [ERROR] raylib headers not found: "%THIRD_PARTY_RAYLIB%\include\raylib.h"
  echo         Set up the built raylib tree under mruby\third_party\raylib or set RAYLIB_ROOT for the gem build.
  exit /b 1
)

if not exist "%THIRD_PARTY_RAYLIB%\lib\libraylib.a" (
  echo [ERROR] raylib library not found: "%THIRD_PARTY_RAYLIB%\lib\libraylib.a"
  echo         Set up the built raylib tree under mruby\third_party\raylib or set RAYLIB_ROOT for the gem build.
  exit /b 1
)

if not exist "%MRUBY_BUILD_DIR%" mkdir "%MRUBY_BUILD_DIR%"
if errorlevel 1 (
  echo [ERROR] Failed to create build directory: "%MRUBY_BUILD_DIR%"
  exit /b 1
)

echo [INFO] Building mruby with Visual Studio config...
echo [INFO]   source : %THIRD_PARTY_MRUBY%
echo [INFO]   config : %VS_CONFIG%
echo [INFO]   raylib : %THIRD_PARTY_RAYLIB%
echo [INFO]   rake   : %RAKE_CMD%
echo [INFO]   build  : %MRUBY_BUILD_DIR%

pushd "%THIRD_PARTY_MRUBY%"
if errorlevel 1 (
  echo [ERROR] Failed to enter mruby source directory.
  exit /b 1
)

set "MRUBY_BUILD_DIR=%MRUBY_BUILD_DIR_RB%"
set "MRUBY_CONFIG=%VS_CONFIG_RB%"
call %RAKE_CMD% all
:: call %RAKE_CMD% clean all
:: call %RAKE_CMD% --verbose clean all
set "BUILD_EXIT=%ERRORLEVEL%"
popd

if not "%BUILD_EXIT%"=="0" (
  echo [ERROR] mruby build failed. exit code: %BUILD_EXIT%
  exit /b %BUILD_EXIT%
)

exit /b 0

:help
echo Usage: %~nx0

exit /b 0
