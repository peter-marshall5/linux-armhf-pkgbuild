#!/bin/bash

. PKGBUILD
mkdir -p linux

cp .config .whitelist linux/

echo "Downloading Linux kernel source..."
pushd linux
wget "${kernurl}" -O - | tar xJvf - --strip-components=1

echo "Applying patches..."
find ../patches/ -type f -exec sh -c "patch -p1 < {}" \;
popd
