cmake_minimum_required(VERSION 3.20)
project(physac C)

include(GNUInstallDirs)

option(BUILD_PLATFORM "arm64, aarch64, x86_64, etc." "x86_64")

set(PROJECT_VERSION 3.0)
set(API_VERSION 300)

include_directories( ${CMAKE_CURRENT_LIST_DIR}/../raylib_dll/raylib/src )
include_directories( ${CMAKE_CURRENT_LIST_DIR}/physac_dll/physac/src )
include_directories(.)

if (APPLE)
    link_directories(${CMAKE_CURRENT_LIST_DIR}/../raylib_dll/build_${BUILD_PLATFORM}/raylib)
elsif(EMSCRIPTEN)
    link_directories(${CMAKE_CURRENT_LIST_DIR}/../raylib_dll/build_wasm/raylib)
else()
    link_directories(${CMAKE_CURRENT_LIST_DIR}/../raylib_dll/build/raylib)
endif()

add_definitions("-DPHYSAC_NO_THREADS")
# add_definitions("-DPHYSAC_STANDALONE")

set(PHYSAC_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/physac.c
	)

# For " Policy CMP0042 is not set: MACOSX_RPATH is enabled by default."
if (APPLE)
    set(CMAKE_MACOSX_RPATH ON)
endif (APPLE)

if (BUILD_LIBTYPE_SHARED)
    add_library(physac SHARED ${PHYSAC_SOURCES})
else()
    add_library(physac STATIC ${PHYSAC_SOURCES})
endif()

set_target_properties(physac PROPERTIES
    PREFIX ""
    PUBLIC_HEADER ${CMAKE_CURRENT_LIST_DIR}/physac/src/physac.h
    )

target_link_libraries(physac raylib)

if (APPLE)
    set_target_properties(physac PROPERTIES
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
	)
endif (APPLE)


#install
install(TARGETS physac
              RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
              LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
              ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
              PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
              )
