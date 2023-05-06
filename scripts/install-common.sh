#!/bin/bash

root=$(git rev-parse --show-toplevel)
. ./scripts/utils.sh

update_system

upgrade_system

packages="neovim \
         neofetch \
         git-man"

install_packages $packages

write_info "check if cargo is already installed"
if [ ! -x $(command -v cargo)]; then
    ./scripts/install-cargo.sh
fi

write_info "installing rust crates"
. "$HOME/.cargo/env"
cargo install \
      git-delta \
      bat \
      exa \
      ripgrep \
      fd-find \
      du-dust \
      procs \
      tokei

write_success "setup complete"
