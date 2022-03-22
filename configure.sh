#!/bin/bash

. ./envvars.sh

cd linux
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE -j$(($(nproc)+1)) oldconfig
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE -j$(($(nproc)+1)) nconfig
