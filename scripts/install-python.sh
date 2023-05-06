#!/bin/bash

root=$(git rev-parse --show-toplevel)
. $root/scripts/utils.sh

bin=/usr/local
program="python"
targetdir=$bin/$program
default="3.10.9"

[ -d $targetdir ] || mkdir -p $targetdir
pushd $bin > /dev/null
read_version

update_system

install_packages "gdebi-core python libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev"

tarball=Python-$version.tgz
url=https://www.python.org/ftp/python/$version/$tarball
download_tarball $url $targetdir/$tarball

unpacking_tarball $targetdir/$tarball $targetdir

write_info "installing $program now"
cd $targetdir/Python-$version
./configure \
    --prefix=$targetdir \
    --enable-shared \
    --enable-optimizations \
    --with-lto \
    --enable-ipv6 \
    --with-ensurepip=upgrade \
    LDFLAGS=-Wl,-rpath=$targetdir/lib,--disable-new-dtags

make
make install

verify_program $targetdir/bin/python3

make_symlink $targetdir/bin/python3 /usr/bin/python3

clean_up ./get-pip.py $targetdir/$tarball
write_success "installation is complete"
popd > /dev/null
