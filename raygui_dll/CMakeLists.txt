Project(raygui C)
cmake_minimum_required(VERSION 3.0)

set(PROJECT_VERSION 3.0)
set(API_VERSION 300)

include_directories( ${CMAKE_CURRENT_LIST_DIR}/../raylib_dll/raylib/src )
include_directories( ${CMAKE_CURRENT_LIST_DIR}/raygui_dll/raygui/src )
include_directories(.)

link_directories(${CMAKE_CURRENT_LIST_DIR}/../raylib_dll/build/raylib)

add_definitions("-DBUILD_LIBTYPE_SHARED")
# add_definitions("-DRAYGUI_STANDALONE")
# add_definitions("-DBLANK=(Color){0, 0, 0, 0}")

set(RAYGUI_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/raygui.c
	)

# For " Policy CMP0042 is not set: MACOSX_RPATH is enabled by default."
if (APPLE)
    set(CMAKE_MACOSX_RPATH ON)
endif (APPLE)

add_library(raygui SHARED ${RAYGUI_SOURCES})

set_target_properties(raygui PROPERTIES PREFIX "")

target_link_libraries(raygui raylib)

if (APPLE)
    set_target_properties(raygui PROPERTIES
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
	)
endif (APPLE)


#install
install(TARGETS raygui
              RUNTIME DESTINATION  .
              LIBRARY DESTINATION  .
              ARCHIVE DESTINATION  .
              )
