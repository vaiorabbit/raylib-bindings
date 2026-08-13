@echo off
setlocal EnableExtensions

if /I "%~1"=="-h" goto :help
if /I "%~1"=="--help" goto :help

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "MRUBY_ROOT=%%~fI"
set "THIRD_PARTY_MRUBY=%MRUBY_ROOT%\third_party\mruby"
set "THIRD_PARTY_RAYLIB=%MRUBY_ROOT%\third_party\raylib"
set "VS_CONFIG=%MRUBY_ROOT%\third_party\vs.rb"
set "MRUBY_BUILD_DIR=%MRUBY_ROOT%\bin"
if "%RAKE_CMD%"=="" set "RAKE_CMD=rake"
:: if "%VS_ARCH%"=="" set "VS_ARCH=x64"
:: if "%VS_HOST_ARCH%"=="" set "VS_HOST_ARCH=%VS_ARCH%"

set "MRUBY_BUILD_DIR_RB=%MRUBY_BUILD_DIR:\=/%"
set "VS_CONFIG_RB=%VS_CONFIG:\=/%"

if not exist "%THIRD_PARTY_MRUBY%\Rakefile" (
  echo [ERROR] mruby submodule is not initialized: "%THIRD_PARTY_MRUBY%"
  echo         Run: git submodule update --init --recursive
  exit /b 1
)

if not exist "%VS_CONFIG%" (
  echo [ERROR] Visual Studio config not found: "%VS_CONFIG%"
  exit /b 1
)

if not exist "%THIRD_PARTY_RAYLIB%\include\raylib.h" (
  echo [ERROR] raylib headers not found: "%THIRD_PARTY_RAYLIB%\include\raylib.h"
  echo         Set up the built raylib tree under mruby\third_party\raylib or set RAYLIB_ROOT for the gem build.
  exit /b 1
)

if not exist "%THIRD_PARTY_RAYLIB%\lib\raylib.lib" (
  echo [ERROR] raylib library not found: "%THIRD_PARTY_RAYLIB%\lib\raylib.lib"
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

:: if not defined VSINSTALLDIR (
::   for /f "usebackq delims=" %%I in (`where vswhere.exe 2^>nul`) do set "VSWHERE=%%I"
::   if not defined VSWHERE if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
::   if defined VSWHERE (
::     for /f "usebackq delims=" %%I in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set "VSINSTALLDIR=%%I\"
::   )
:: )
:: 
:: if defined VSINSTALLDIR (
::   if exist "%VSINSTALLDIR%Common7\Tools\VsDevCmd.bat" (
::     call "%VSINSTALLDIR%Common7\Tools\VsDevCmd.bat" -arch=%VS_ARCH% -host_arch=%VS_HOST_ARCH%
::   ) else if exist "%VSINSTALLDIR%Common7\Tools\VsDevCmd.cmd" (
::     call "%VSINSTALLDIR%Common7\Tools\VsDevCmd.cmd" -arch=%VS_ARCH% -host_arch=%VS_HOST_ARCH%
::   ) else (
::     echo [ERROR] VsDevCmd not found under "%VSINSTALLDIR%"
::     exit /b 1
::   )
:: ) else (
::   echo [ERROR] Visual Studio installation not found.
::   echo         Open a VS x64 Developer Command Prompt or set VSINSTALLDIR before running this script.
::   exit /b 1
:: )

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

set "BUILD_HOST=%MRUBY_BUILD_DIR%\host"

if not exist "%BUILD_HOST%\bin" (
  echo [ERROR] Build output not found: "%BUILD_HOST%\bin"
  exit /b 1
)
if not exist "%BUILD_HOST%\lib" (
  echo [ERROR] Build output not found: "%BUILD_HOST%\lib"
  exit /b 1
)
if not exist "%BUILD_HOST%\include" (
  echo [ERROR] Build output not found: "%BUILD_HOST%\include"
  exit /b 1
)

dir /b "%BUILD_HOST%\bin\*" >nul 2>&1
if errorlevel 1 (
  echo [ERROR] No built binaries found in "%BUILD_HOST%\bin"
  exit /b 1
)

dir /b "%BUILD_HOST%\lib\*" >nul 2>&1
if errorlevel 1 (
  echo [ERROR] No built libraries found in "%BUILD_HOST%\lib"
  exit /b 1
)

echo [OK] mruby build complete.
echo [OK] artifacts available under "%BUILD_HOST%"
exit /b 0

:help
echo Usage: %~nx0
echo.
echo Build mruby from mruby\third_party\mruby using Visual Studio config.
:: echo The script initializes a VS x64 developer environment before invoking rake.
echo Output artifacts are generated under mruby\build\host.
echo Temporary build output is placed under mruby\build.
echo.
echo Optional environment variables:
echo   RAKE_CMD   Path to rake executable ^(default: rake^)
:: echo   VS_ARCH    Target architecture for Visual Studio tools ^(default: x64^)
:: echo   VS_HOST_ARCH  Host architecture for Visual Studio tools ^(default: x64^)
exit /b 0
