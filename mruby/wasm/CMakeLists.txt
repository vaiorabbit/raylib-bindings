project(mrb_test)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Os -s USE_GLFW=3 -s ASSERTIONS=1 -s WASM=1 -s ASYNCIFY")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -s ALLOW_MEMORY_GROWTH=1 --no-heap-copy")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --shell-file ${CMAKE_CURRENT_LIST_DIR}/../../raylib_dll/raylib/src/shell.html")
set(CMAKE_EXECUTABLE_SUFFIX ".html")
string(REPLACE "-rdynamic" "" CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "${CMAKE_SHARED_LIBRARY_LINK_C_FLAGS}")

add_executable(mrb_test ${CMAKE_CURRENT_LIST_DIR}/../mrb_test.c)

target_include_directories(mrb_test PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/../../raylib_dll/raylib/include
    ${CMAKE_CURRENT_LIST_DIR}/../mruby/build/emscripten/include
)

target_link_libraries(mrb_test
	${CMAKE_CURRENT_LIST_DIR}/../../raylib_dll/build/raylib/libraylib.a
	${CMAKE_CURRENT_LIST_DIR}/../mruby/build/emscripten/lib/libmruby.a
)

target_link_options(mrb_test PRIVATE "-sUSE_GLFW=3")
