#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel)

create_symlink() {
    local src=$1 dst=$2

    if [ ! -L $dst ]; then
        ln -s $src $dst -v
    fi
}

install_dotfiles() {
    find -H $DOTFILES -maxdepth 3 -name "links.prop" | while read linkfile
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

            create_symlink $src $dst
        done
    done
}

pushd $DOTFILES > /dev/null
install_dotfiles
echo "done"
popd > /dev/null
