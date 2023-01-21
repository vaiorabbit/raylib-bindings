<!-- -*- mode:markdown; coding:utf-8; -*- -->

# Yet another raylib wrapper for Ruby #

*   Created : 2021-10-17
*   Last modified : 2023-01-21

Provides Ruby bindings for raylib-related libraries including:

*   [raylib](https://github.com/raysan5/raylib)
    *   raylib
    *   raymath
    *   rlgl
*   [raygui](https://github.com/raysan5/raygui)
*   [Physac](https://github.com/raysan5/physac)

<img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings/main/doc/bitmap_font_rb.png" width="125"> <img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings/main/doc/game_of_life_simple_rb.png" width="125"> <img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings/main/doc/lissajous_curve_rb.png" width="125"> <img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings/main/doc/procedural_texture_rb.png" width="125"> <img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings/main/doc/reversi_board_rb.png" width="125"> <img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings/main/doc/utf8_font_rb.png" width="125">

## Features ##

*   Generated semi-automatically
*   Based on Ruby/FFI
    *   No need to build C extension library

## Quick Start ##

For Windows and macOS users:

```
D:\> gem install raylib-bindings
Fetching raylib-bindings-...
...
1 gem installed

D:\> ruby -r raylib -e 'Raylib.template'
[Info] Raylib.template : C:/Ruby31-x64/lib/ruby/gems/3.1.0/gems/raylib-bindings-0.0.11/examples/template.rb => d://template.rb
[Info] Raylib.template : Done

D:\> ruby template.rb
```
↓

<img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings/main/doc/template_screenshot.png" width="400">

## Prerequisites ##

*   Ruby interpreter
    *   Tested on:
        *   [macOS]
            *   ruby 3.2.0 (2022-12-25 revision a528908271) [arm64-darwin21]
        *   [Windows] https://rubyinstaller.org/downloads/ Ruby+Devkit
            *   ruby 3.2.0 (2022-12-25 revision a528908271) [x64-mingw-ucrt]

*   If you need to build DLLs/shared libralies for your own runtime envrioenment (Linux, etc.):
    *   CMake https://cmake.org/download/
    *   C Compiler
        *   Tested compilers:
            *   [macOS] clang

                    $ clang --version
                    Apple clang version 14.0.0 (clang-1400.0.29.202)
                    Target: arm64-apple-darwin22.2.0
                    Thread model: posix
                    InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

            *   [Windows] gcc

                    gcc (Rev7, Built by MSYS2 project) 12.2.0


<details>
<summary>Older versions</summary>

*   Ruby interpreter
    *   Tested on:
        *   [macOS]
            *   ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [arm64-darwin21]
            *   ruby 3.1.0p0 (2021-12-25 revision fb4df44d16) [arm64-darwin20]
            *   ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [arm64-darwin20]
        *   [Windows] https://rubyinstaller.org/downloads/ Ruby+Devkit
            *   ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x64-mingw-ucrt]
            *   ruby 3.1.1p18 (2022-02-18 revision 53f5fc4236) [x64-mingw-ucrt]
            *   ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x64-mingw32]

*   Compiler
    *   Tested on:
        *   [macOS] clang

                $ clang --version
                Apple clang version 13.1.6 (clang-1316.0.21.2.5)
                Target: arm64-apple-darwin21.5.0
                Thread model: posix
                InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

                $ clang --version
                Apple clang version 13.1.6 (clang-1316.0.21.2.3)
                Target: arm64-apple-darwin21.5.0
                Thread model: posix
                InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

                Apple clang version 13.0.0 (clang-1300.0.29.3)
                Target: arm64-apple-darwin20.6.0
                Thread model: posix
                InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

        *   [Windows] gcc

                gcc (Rev9, Built by MSYS2 project) 11.2.0
                gcc (Rev10, Built by MSYS2 project) 11.2.0

</details>

## Project ##

See the project below to learn how to use this library:

*   Whac-a-Mole! : Ruby raylib bindings demo
    *   <img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings-whacamole/main/doc/screenshot_00.png" width="300"> <img src="https://raw.githubusercontent.com/vaiorabbit/raylib-bindings-whacamole/main/doc/screenshot_01.png" width="300">
    *   <https://github.com/vaiorabbit/raylib-bindings-whacamole>

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
    *   Physac ( https://github.com/raysan5/physac )
        *   https://github.com/raysan5/physac/blob/4a8e17f263fb8e1150b3fbafc96f880c7d7a4833/src/physac.h#L51-L68

All ruby codes here are available under the terms of the zlib/libpng License ( http://opensource.org/licenses/Zlib ).

    Ruby-raylib : Yet another raylib wrapper for Ruby
    Copyright (c) 2021-2023 vaiorabbit <http://twitter.com/vaiorabbit>

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
