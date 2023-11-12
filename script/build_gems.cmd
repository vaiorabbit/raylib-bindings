@echo off
pushd %CD%
cd ..
call gem.cmd build raylib-bindings.gemspec
call gem.cmd build raylib-bindings.gemspec --platform arm64-darwin
call gem.cmd build raylib-bindings.gemspec --platform x86_64-darwin
call gem.cmd build raylib-bindings.gemspec --platform aarch64-linux
call gem.cmd build raylib-bindings.gemspec --platform x86_64-linux
call gem.cmd build raylib-bindings.gemspec --platform x64-mingw
popd
