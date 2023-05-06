#!/bin/bash

root=$(git rev-parse --show-toplevel)
. $root/scripts/utils.sh

pushd /tmp > /dev/null

write_info "downloading rustup script"
script=tmp.sh
wget https://sh.rustup.rs -O $script

write_info "installing cargo from source"
chmod u+x $script
bash $script -y

write_info "reconfiguring current shell"
. "$HOME/.cargo/env"

clean_up $script
popd > /dev/null
