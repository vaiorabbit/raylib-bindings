pushd .
cd ../raylib_dll
rm -r -f build
./build_raylib_linux_cross.sh
popd

pushd .
cd ../physac_dll
rm -r -f build
./build_physac_linux_cross.sh
popd

pushd .
cd ../raygui_dll
rm -r -f build
./build_raygui_linux_cross.sh
popd

