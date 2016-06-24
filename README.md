## ♜ ♝ ♞

[![Continuous Integration](https://travis-ci.org/daniel-j-h/cku.svg?branch=master)](https://travis-ci.org/daniel-j-h/cku)

## Building

    pushd third_party && ./build.sh && popd
    ./build.sh

With [Nix](https://nixos.org/nix/):

    nix-shell --pure --run 'pushd third_party && ./build.sh && popd'
    nix-shell --pure --run './build.sh'

## License

Copyright © 2016 Daniel J. Hofmann

Distributed under the MIT License (MIT).
