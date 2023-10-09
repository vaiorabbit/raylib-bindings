# Usage : $ bash wsl_rebuild_linux_cross.sh foo /mnt/d/Users/foo/workbench/raylib-bindings/lib
bash tmp_rebuild_linux_cross.sh $1
cp /tmp/raylib-bindings/lib/*.aarch64.so $2
