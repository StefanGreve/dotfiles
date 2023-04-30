#!/bin/bash

i=1
n=4

pushd /tmp > /dev/null

echo "[$i/$n] downloading rustup script"
script=tmp.sh
wget https://sh.rustup.rs -O $script
((i++))

echo "[$i/$n] installing cargo from source"
chmod u+x $script
bash $script -y
((i++))

echo "[$i/$n] reconfiguring current shell"
source "$HOME/.cargo/env"
((i++))

echo "[$i/$n] installation complete, initiating cleanup . . ."
rm $script
popd > /dev/null
