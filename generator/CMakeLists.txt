cmake_minimum_required(VERSION 3.0)
project(raylib_parser)

file(GLOB RAYLIBPARSER_SOURCES ${CMAKE_CURRENT_LIST_DIR}/../raylib_dll/raylib/parser/raylib_parser.c)

add_executable(raylib_parser ${RAYLIBPARSER_SOURCES})


