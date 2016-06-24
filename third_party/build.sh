#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

readonly prefix=$(realpath ${1:-build})


echo "Downloading Sources .."

wget --quiet --continue --no-check-certificate \
  https://github.com/aquynh/capstone/archive/4.0-alpha2.tar.gz \
  -O capstone-4.0-alpha2.tar.gz &

wget --quiet --continue --no-check-certificate \
  https://github.com/keystone-engine/keystone/archive/0.9.tar.gz \
  -O keystone-0.9.tar.gz &

wget --quiet --continue --no-check-certificate \
  https://github.com/unicorn-engine/unicorn/archive/0.9.tar.gz \
  -O unicorn-0.9.tar.gz &

wait


echo "Verifying Checksums .."

sha256sum --check << EOF
8759f2df27648676a75840df5bc10be2540839e97a31897c6d1a7cbe03b8cb1e  capstone-4.0-alpha2.tar.gz
94c58243dae1ec65a97d2ba02abb2323b4e5c82501eb7f8cfd85b460a0194157  keystone-0.9.tar.gz
1ca03b1c8f6360335567b528210713461e839d47c4eb7c676ba3aa4f72b8cf10  unicorn-0.9.tar.gz
EOF


echo "Extracting Sources .."

for pkg in *.tar.gz
do
  tar xf ${pkg} &
done

wait


echo "Building Capstone for x86 .."

mkdir -p capstone-4.0-alpha2/build && pushd $_

cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=${prefix} \
  -DCAPSTONE_ARM64_SUPPORT=OFF \
  -DCAPSTONE_ARM_SUPPORT=OFF \
  -DCAPSTONE_BUILD_SHARED=OFF \
  -DCAPSTONE_BUILD_TESTS=OFF \
  -DCAPSTONE_MIPS_SUPPORT=OFF \
  -DCAPSTONE_PPC_SUPPORT=OFF \
  -DCAPSTONE_SPARC_SUPPORT=OFF \
  -DCAPSTONE_SYSZ_SUPPORT=OFF \
  -DCAPSTONE_XCORE_SUPPORT=OFF

cmake --build .
cmake --build . --target install
popd


echo "Building Keystone for x86 .."

mkdir -p keystone-0.9/build && pushd $_

cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=${prefix} \
  -DLLVM_ENABLE_CXX1Y=ON

cmake --build .
cmake --build . --target install
popd


echo "Building Unicorn for x86 .."

pushd unicorn-0.9

UNICORN_ARCHS="x86" UNICORN_STATIC="yes" UNICORN_SHARED="no" PREFIX="${prefix}" ./make.sh
UNICORN_ARCHS="x86" UNICORN_STATIC="yes" UNICORN_SHARED="no" PREFIX="${prefix}" ./make.sh install

popd
