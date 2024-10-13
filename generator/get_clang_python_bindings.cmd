@echo off
mkdir clang
pushd .
cd clang
curl -O https://raw.githubusercontent.com/llvm/llvm-project/88e42c6779067c4b65624939be74db2d56ee017b/clang/bindings/python/clang/__init__.py
curl -O https://raw.githubusercontent.com/llvm/llvm-project/88e42c6779067c4b65624939be74db2d56ee017b/clang/bindings/python/clang/cindex.py
curl -O https://raw.githubusercontent.com/llvm/llvm-project/88e42c6779067c4b65624939be74db2d56ee017b/clang/bindings/python/clang/enumerations.py
popd
