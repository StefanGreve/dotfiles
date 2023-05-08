#!/bin/bash

root=$(git rev-parse --show-toplevel)
. $root/scripts/utils.sh

install_dotfiles() {
    find -H $root -maxdepth 3 -name "links.prop" | while read linkfile
    do
        cat $linkfile | while read line
        do
            local src dst dir
            src=$(eval echo $line | cut -d '=' -f 1)
            dst=$(eval echo $line | cut -d '=' -f 2)
            dir=$(dirname dst)

            if [ -d $dir ]; then
                mkdir -p $dir > /dev/null
            fi

            make_symlink $src $dst
        done
    done
}

pushd $root > /dev/null
install_dotfiles
write_success "execution completed"
popd > /dev/null
