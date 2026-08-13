cmake_minimum_required(VERSION 3.20)

project(code_pacone)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Os -sUSE_GLFW=3 -sASSERTIONS=1 -sWASM=1 -sASYNCIFY")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -s ALLOW_MEMORY_GROWTH=1 -s SUPPORT_LONGJMP=wasm")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --shell-file ${CMAKE_CURRENT_LIST_DIR}/../../../raylib_dll/raylib/src/shell.html")
set(CMAKE_EXECUTABLE_SUFFIX ".html")

add_executable(code_pacone
	code_pacone.c
	code_pacone.h
)

set(REPO_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../../..")
set(MRUBY_ROOT "${REPO_ROOT}/mruby")

set(RAYLIB_INCLUDE_DIR "${MRUBY_ROOT}/third_party/raylib/wasm/include")
set(RAYLIB_LIBRARY_DIR "${MRUBY_ROOT}/third_party/raylib/wasm/lib")
if(NOT EXISTS "${RAYLIB_LIBRARY_DIR}/libraylib.a")
	set(RAYLIB_LIBRARY_DIR "${MRUBY_ROOT}/third_party/raylib/lib")
endif()
set(RAYLIB_LIBRARY "${RAYLIB_LIBRARY_DIR}/libraylib.a")

set(MRUBY_INCLUDE_DIR "${MRUBY_ROOT}/bin_web/emscripten/include")
set(MRUBY_LIBRARY_DIR "${MRUBY_ROOT}/bin_web/emscripten/lib")
set(MRUBY_LIBRARY "${MRUBY_LIBRARY_DIR}/libmruby.a")

target_include_directories(code_pacone PRIVATE
	"${RAYLIB_INCLUDE_DIR}"
	"${MRUBY_INCLUDE_DIR}"
)

target_link_directories(code_pacone PRIVATE
	"${RAYLIB_LIBRARY_DIR}"
	"${MRUBY_LIBRARY_DIR}"
)

target_link_libraries(code_pacone PRIVATE
	"${RAYLIB_LIBRARY}"
	"${MRUBY_LIBRARY}"
)
