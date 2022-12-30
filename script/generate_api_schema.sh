#!/bin/sh
cc ../raylib_dll/raylib/parser/raylib_parser.c -o ./raylib_parser
./raylib_parser -i ../raylib_dll/raylib/src/raylib.h -o ../generator/raylib_api.json -f JSON -d RLAPI
./raylib_parser -i ../raylib_dll/raylib/src/config.h -o ../generator/config_api.json -f JSON
./raylib_parser -i ../raylib_dll/raylib/src/raymath.h -o ../generator/raymath_api.json -f JSON -d RMAPI
./raylib_parser -i ../raylib_dll/raylib/src/rlgl.h -o ../generator/rlgl_api.json -f JSON -d RLAPI -t "RLGL IMPLEMENTATION"
./raylib_parser -i ../physac_dll/physac/src/physac.h -o ../generator/physac_api.json -f JSON -d PHYSACDEF -t "PHYSAC IMPLEMENTATION"
./raylib_parser -i ../raygui_dll/raygui/src/raygui.h -o ../generator/raygui_api.json -f JSON -d RAYGUIAPI -t "RAYGUI IMPLEMENTATION"

rm ./raylib_parser
