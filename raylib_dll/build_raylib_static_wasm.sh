mkdir -p build
cd build
emcmake cmake -D PLATFORM=Web -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=OFF -D BUILD_EXAMPLES=OFF ../raylib
cmake --build .
