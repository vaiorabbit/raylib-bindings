<!-- -*- mode:markdown; coding:utf-8; -*- -->

# Yet another raylib wrapper for Ruby #

Provides Ruby bindings for raylib-related libraries including:
*   [raylib](https://github.com/raysan5/raylib)
    *   raylib
    *   raymath
    *   rlgl
*   [raygui](https://github.com/raysan5/raygui)
*   [Physac](https://github.com/victorfisac/Physac)


*   Created : 2021-10-17
*   Last modified : 2022-02-26

## Features ##

*   Generated semi-automatically
*   Based on Ruby/FFI
    *   No need to build C extension library

## Prerequisites ##

*   Ruby interpreter
    *   Tested on:
        *   [macOS]
            *   ruby 3.1.0p0 (2021-12-25 revision fb4df44d16) [arm64-darwin20]
            *   ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [arm64-darwin20]
        *   [Windows] https://rubyinstaller.org/downloads/ Ruby+Devkit
            *   ruby 3.1.1p18 (2022-02-18 revision 53f5fc4236) [x64-mingw-ucrt]
            *   ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x64-mingw32]

*   Compiler
    *   Tested on:
        *   [macOS] clang

                Apple clang version 13.0.0 (clang-1300.0.29.3)
                Target: arm64-apple-darwin20.6.0
                Thread model: posix
                InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

        *   [Windows] gcc

                gcc (Rev9, Built by MSYS2 project) 11.2.0

*   CMake https://cmake.org/download/

## Limitation ##

*   `SetTraceLogCallback` and `TraceLogCallback` are unusable since Ruby-FFI does not support `:varargs` parameter in callbacks (`Proc`, etc.)
    *   Ref.: https://ffi.github.io/ruby-ffi-archive/messages/20130214-%5Bruby-ffi%5D%20Re_%20Callback%20Function%20with%20varargs-345.html

## License ##

Shared libraries in `lib` directory are built on top of these products and are available under the terms of these licenses:

*   `libraylib.dylib`, `libraylib.dll`
    *   raylib ( https://github.com/raysan5/raylib )
        *   https://github.com/raysan5/raylib/blob/master/LICENSE
*   `raygui.dylib`, `raygui.dll`
    *   raygui ( https://github.com/raysan5/raygui )
        *   https://github.com/raysan5/raygui/blob/master/LICENSE
*   `physac.dylib`, `physac.dll`
    *   Physac ( https://github.com/victorfisac/Physac )
        *   https://github.com/victorfisac/Physac/blob/a8a6c864bfc809f8e4b2f88bb916b90d736b3f4a/src/physac.h#L59-L76

All ruby codes here are available under the terms of the zlib/libpng License ( http://opensource.org/licenses/Zlib ).

    Ruby-raylib : Yet another raylib wrapper for Ruby
    Copyright (c) 2021-2022 vaiorabbit <http://twitter.com/vaiorabbit>

    This software is provided 'as-is', without any express or implied
    warranty. In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

        1. The origin of this software must not be misrepresented; you must not
        claim that you wrote the original software. If you use this software
        in a product, an acknowledgment in the product documentation would be
        appreciated but is not required.

        2. Altered source versions must be plainly marked as such, and must not be
        misrepresented as being the original software.

        3. This notice may not be removed or altered from any source
        distribution.
