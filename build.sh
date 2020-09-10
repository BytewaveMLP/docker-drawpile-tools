#!/bin/sh

# Modified from Drawpile's build scripts
# https://github.com/drawpile/Drawpile/tree/master/pkg/docker

unzip drawpile.zip
cd Drawpile-*/

mkdir build
cd build

cmake .. -DCLIENT=ON -DSERVER=OFF -DSERVERGUI=OFF -DINSTALL_DOC=OFF -DTOOLS=ON -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)

mkdir ../../bin
cp bin/* ../../bin
