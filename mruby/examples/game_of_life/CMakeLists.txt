cmake_minimum_required(VERSION 3.20)

project(game_of_life)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Os -sUSE_GLFW=3 -sASSERTIONS=1 -sWASM=1 -sASYNCIFY")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -s ALLOW_MEMORY_GROWTH=1 -s SUPPORT_LONGJMP=wasm")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --shell-file ${CMAKE_CURRENT_LIST_DIR}/shell.html")
set(CMAKE_EXECUTABLE_SUFFIX ".html")

add_executable(game_of_life
	main.c
	ruby_code.h
)

set(REPO_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../../..")
set(MRUBY_ROOT "${REPO_ROOT}/mruby")

set(RAYLIB_INCLUDE_DIR "${MRUBY_ROOT}/third_party/raylib/wasm/include")
set(RAYLIB_LIBRARY_DIR "${MRUBY_ROOT}/third_party/raylib/wasm/lib")
if(NOT EXISTS "${RAYLIB_LIBRARY_DIR}/libraylib.a")
	set(RAYLIB_LIBRARY_DIR "${MRUBY_ROOT}/third_party/raylib/lib")
endif()
set(RAYLIB_LIBRARY "${RAYLIB_LIBRARY_DIR}/libraylib.a")

set(RAYGUI_INCLUDE_DIR "${MRUBY_ROOT}/third_party/raygui/wasm/include")
set(RAYGUI_LIBRARY_DIR "${MRUBY_ROOT}/third_party/raygui/wasm/lib")
if(NOT EXISTS "${RAYGUI_LIBRARY_DIR}/raygui.a")
	set(RAYGUI_LIBRARY_DIR "${MRUBY_ROOT}/third_party/raygui/lib")
endif()
set(RAYGUI_LIBRARY "${RAYGUI_LIBRARY_DIR}/raygui.a")

set(PHYSAC_INCLUDE_DIR "${MRUBY_ROOT}/third_party/physac/wasm/include")
set(PHYSAC_LIBRARY_DIR "${MRUBY_ROOT}/third_party/physac/wasm/lib")
if(NOT EXISTS "${PHYSAC_LIBRARY_DIR}/physac.a")
	set(PHYSAC_LIBRARY_DIR "${MRUBY_ROOT}/third_party/physac/lib")
endif()
set(PHYSAC_LIBRARY "${PHYSAC_LIBRARY_DIR}/physac.a")

set(MRUBY_INCLUDE_DIR "${MRUBY_ROOT}/bin_web/emscripten/include")
set(MRUBY_LIBRARY_DIR "${MRUBY_ROOT}/bin_web/emscripten/lib")
set(MRUBY_LIBRARY "${MRUBY_LIBRARY_DIR}/libmruby.a")

target_include_directories(game_of_life PRIVATE
	"${RAYLIB_INCLUDE_DIR}"
	"${RAYGUI_INCLUDE_DIR}"
	"${PHYSAC_INCLUDE_DIR}"
	"${MRUBY_INCLUDE_DIR}"
)

target_link_directories(game_of_life PRIVATE
	"${RAYLIB_LIBRARY_DIR}"
	"${RAYGUI_LIBRARY_DIR}"
	"${PHYSAC_LIBRARY_DIR}"
	"${MRUBY_LIBRARY_DIR}"
)

target_link_libraries(game_of_life PRIVATE
	"${RAYLIB_LIBRARY}"
	"${RAYGUI_LIBRARY}"
	"${PHYSAC_LIBRARY}"
	"${MRUBY_LIBRARY}"
)
