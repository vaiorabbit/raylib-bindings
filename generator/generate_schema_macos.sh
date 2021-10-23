PARSER=build/raylib_parser
SRC=../raylib_dll/raylib/src

mkdir -p schema
${PARSER} --input ${SRC}/raylib.h --output schema/raylib_api.json --format JSON --define RLAPI
${PARSER} --input ${SRC}/raymath.h --output schema/raymath_api.json --format JSON --define RMAPI
${PARSER} --input ${SRC}/rlgl.h --output schema/rlgl_api.json --format JSON --define RLAPI
