cmake_minimum_required(VERSION 3.20)

project(code_pacone C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_executable(code_pacone
	code_pacone.c
	code_pacone.h
)

# Repository root from mruby/examples/embedding
set(REPO_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../../..")
set(MRUBY_ROOT "${REPO_ROOT}/mruby")

set(RAYLIB_INCLUDE_DIR "${MRUBY_ROOT}/third_party/raylib")
# Prefer mruby/third_party/lib when present, fallback to mruby/third_party/raylib/lib.
set(RAYLIB_LIBRARY_DIR "${MRUBY_ROOT}/third_party/lib")
if(NOT EXISTS "${RAYLIB_LIBRARY_DIR}/raylib.lib")
	set(RAYLIB_LIBRARY_DIR "${MRUBY_ROOT}/third_party/raylib/lib")
endif()
set(RAYLIB_LIBRARY "${RAYLIB_LIBRARY_DIR}/raylib.lib")

set(MRUBY_INCLUDE_DIR "${MRUBY_ROOT}/bin/host/include")
set(MRUBY_LIBRARY_DIR "${MRUBY_ROOT}/bin/host/lib")
set(MRUBY_LIBRARY "${MRUBY_LIBRARY_DIR}/libmruby.lib")

target_include_directories(code_pacone PRIVATE
	"${RAYLIB_INCLUDE_DIR}"
	"${MRUBY_INCLUDE_DIR}"
)

target_link_directories(code_pacone PRIVATE
	"${RAYLIB_LIBRARY_DIR}"
	"${MRUBY_LIBRARY_DIR}"
)

if(WIN32)
	if(MSVC)
		# Current raylib.lib exports symbols that collide with Win32 import libs
		# (CloseWindow/ShowCursor/PlaySound). Allow duplicates as a local workaround.
		target_link_options(code_pacone PRIVATE /FORCE:MULTIPLE)
	endif()

	# raylib.lib must be linked first to resolve naming conflicts between raylib APIs (e.g., CloseWindow, ShowCursor, PlaySound) and Win32 APIs.
	# Order of library names should be configured to suppress duplicate definition (LNK4006 and LNK4088).
	target_link_libraries(code_pacone PRIVATE
		"${MRUBY_LIBRARY}" # Changing order may emit warnings (LNK4006 and LNK4088)
		"${RAYLIB_LIBRARY}"
		winmm
		ws2_32
		iphlpapi        
	)
else()
	message(FATAL_ERROR "This CMakeLists.txt currently defines Windows-specific library linkage.")
endif()
