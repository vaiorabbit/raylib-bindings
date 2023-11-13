#!/bin/sh
pushd .
cd ..
for i in `ls raylib-bindings-*.gem`; do
    echo gem push $i
done
popd
