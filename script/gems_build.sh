#!/bin/sh
pushd .
cd ..
gem build raylib-bindings.gemspec
gem build raylib-bindings.gemspec --platform arm64-darwin
gem build raylib-bindings.gemspec --platform x86_64-darwin
gem build raylib-bindings.gemspec --platform aarch64-linux
gem build raylib-bindings.gemspec --platform x86_64-linux
gem build raylib-bindings.gemspec --platform x64-mingw
popd
