PARSER=build/raylib_parser
SRC=../raylib_dll/raylib/src

${PARSER} --input ${SRC}/raylib.h --output raylib_api.json --format JSON --define RLAPI
${PARSER} --input ${SRC}/raymath.h --output raymath_api.json --format JSON --define RMAPI
${PARSER} --input ${SRC}/rlgl.h --output rlgl_api.json --format JSON --define RLAPI
