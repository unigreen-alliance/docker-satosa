#!/bin/sh

image=$(grep FROM Dockerfile | awk '{print $2}')
pkg=$1

exec docker run $image pip3 install ${pkg}== 2>&1 | grep versions | tr ',' "\n" | grep -v versions | sed 's/)//g'
