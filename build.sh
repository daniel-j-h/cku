#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

readonly prefix=$(realpath ${1:-"$(pwd)/third_party/build"})

mkdir -p build && cd $_

cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INCLUDE_PATH=${prefix}/include \
  -DCMAKE_LIBRARY_PATH=${prefix}/lib

cmake --build .
