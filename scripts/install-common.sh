#!/bin/bash

i=1
n=5

echo "[$i/$n] updating system"
apt-get update
((i++))

echo "[$i/$n] performing full system upgrade"
apt-get full-upgrade --yes
((i++))

echo "[$i/$n] installing apt packages"
apt-get install \
        neovim \
        neofetch \
        git-man \
        --yes
((i++))

echo "[$i/$n] check if cargo is already installed"
if [ ! -x $(command -v cargo)]; then
    ./scripts/install-cargo.sh
fi
((i++))

echo "[$i/$n] installing rust crates"
source "$HOME/.cargo/env"
cargo install \
      git-delta \
      bat \
      exa

echo "done"
