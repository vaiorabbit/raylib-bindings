pushd .
cd ../raylib_dll
rm -r -f build
./build_raylib_linux.sh
popd

pushd .
cd ../physac_dll
rm -r -f build
./build_physac_linux.sh
popd

pushd .
cd ../raygui_dll
rm -r -f build
./build_raygui_linux.sh
popd

