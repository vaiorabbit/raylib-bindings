#
# For macOS + Xcode + CMake users.
#

pushd .
cd ../raylib_dll
rm -r -f build
./build_raylib_macos.sh
popd

pushd .
cd ../physac_dll
rm -r -f build
./build_physac_macos.sh
popd

pushd .
cd ../raygui_dll
rm -r -f build
./build_raygui_macos.sh
popd

