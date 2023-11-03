mkdir build
cd build
call emcmake cmake -D PLATFORM=Web -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=OFF -D BUILD_EXAMPLES=OFF ..\raylib
call cmake --build .
