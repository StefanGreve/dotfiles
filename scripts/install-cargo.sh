#!/bin/bash

root=$(git rev-parse --show-toplevel)
source $root/scripts/utils.sh

pushd /tmp > /dev/null

write_info "downloading rustup script"
script=tmp.sh
wget https://sh.rustup.rs -O $script

write_info "installing cargo from source"
chmod u+x $script
bash $script -y

write_info "reconfiguring current shell"
source "$HOME/.cargo/env"

write_info "installation complete, initiating cleanup . . ."
rm $script
popd > /dev/null
