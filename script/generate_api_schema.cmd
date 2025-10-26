cc ..\raylib_dll\raylib\tools/rlparser\rlparser.c -o .\rlparser
rlparser -i ..\raylib_dll\raylib\src\raylib.h -o ..\generator\raylib_api.json -f JSON -d RLAPI
rlparser -i ..\raylib_dll\raylib\src\config.h -o ..\generator\config_api.json -f JSON
rlparser -i ..\raylib_dll\raylib\src\raymath.h -o ..\generator\raymath_api.json -f JSON -d RMAPI
rlparser -i ..\raylib_dll\raylib\src\rcamera.h -o ..\generator\rcamera_api.json -f JSON
rlparser -i ..\raylib_dll\raylib\src\rlgl.h -o ..\generator\rlgl_api.json -f JSON -d RLAPI -t "RLGL IMPLEMENTATION"
rlparser -i ..\physac_dll\physac\src\physac.h -o ..\generator\physac_api.json -f JSON -d PHYSACDEF -t "PHYSAC IMPLEMENTATION"
rlparser -i ..\raygui_dll\raygui\src\raygui.h -o ..\generator\raygui_api.json -f JSON -d RAYGUIAPI -t "RAYGUI IMPLEMENTATION"

rm rlparser
