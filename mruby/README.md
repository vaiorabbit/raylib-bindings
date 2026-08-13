# Yet another raylib mruby bindings #

*   Created : 2026-08-12
*   Last modified : 2026-08-12

## Prerequisites

### Windows

#### Visual Studio 2026

Use "x64 Native Tools Command Prompt for VS" command prompt.

#### Emscripten (for web browser build)

*   <https://emscripten.org/docs/getting_started/downloads.html>

```
(example) Installing at D:\code\emsdk:

:: Download and install the latest SDK tools.
D:\code\emsdk> emsdk.bat install latest

:: Make the "latest" SDK "active" for the current user. (writes .emscripten file)
D:\code\emsdk> emsdk.bat activate latest

:: Activate PATH and other environment variables in the current terminal
D:\code\emsdk> emsdk_env.bat
```

## Setup

### Build raylib as static libraries

*   Call `raylib_dll/build_raylib_static_windows_vs.cmd`. raylib will be installed at `mruby/third_party/raylib`.
*   Calling `raylib_dll/build_raylib_static_wasm.cmd`. will build raylib with Emscripten and install at `mruby/third_party/raylib/wasm`.

### Build raylib-enabled mruby

*   Make sure that you have mruby submodule at `mruby/third_party/mruby`.
*   Call `mruby/script/build_mruby_vs.cmd` to build mruby as Windows native binaries.
    *   This build includes `mruby/mrbgems/mruby-raylib` to make this mruby raylib-ready.
    *   Artifacts will be available at `mruby/bin/host`.
*   Call `mruby/script/build_mruby_emscripten.cmd` to build mruby for web browser.
    *   Artifacts will be available at `mruby/bin_web/host` and `mruby/bin_web/emscripten`.

## Examples

See `mruby/examples/README.md` for details.
