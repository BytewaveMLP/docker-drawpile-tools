#!/bin/sh

# Modified from Drawpile's build scripts
# https://github.com/drawpile/Drawpile/tree/master/pkg/docker

wget https://github.com/KDE/extra-cmake-modules/archive/v5.55.0.zip -O ecm.zip
wget https://github.com/KDE/karchive/archive/v5.55.0.zip -O karchive.zip

unzip ecm.zip
unzip karchive.zip

cd /build/extra-cmake-modules-*
cmake .
make -j$(nproc) install

cd /build/karchive-*
mkdir build
cd build
cmake ..
make -j$(nproc)
make install
