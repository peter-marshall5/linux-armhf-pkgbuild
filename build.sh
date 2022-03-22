#!/bin/bash

./download-and-patch.sh
./configure.sh
makepkg -sf
