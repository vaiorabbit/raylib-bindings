#
# For macOS + Xcode + CMake users.
#
mkdir -p build
cd build
export MACOSX_DEPLOYMENT_TARGET=11.5
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_OSX_ARCHITECTURES="arm64" -D CMAKE_C_COMPILER=clang ../
make
# cp -R raylib/*.dylib ../..
