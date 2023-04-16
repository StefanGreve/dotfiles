#!/bin/bash

i=1
n=3

echo "[$i/$n] updating system"
apt-get update
((i++))

echo "[$i/$n] performing full system upgrade"
apt-get full-upgrade --yes
((i++))

echo "[$i/$n] installing packages"
apt-get install \
        neovim \
        neofetch \
        --yes

echo "done"
