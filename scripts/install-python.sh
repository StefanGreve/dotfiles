#!/bin/bash

i=1
n=10
bin=/usr/local
default="3.10.9"

pushd $bin > /dev/null
echo "[$i/$n] choose python release (e.g. $default)"
read -p "version: " version
[ -z $version ] && version=$default
((i++))

echo "[$i/$n] updating system"
apt-get update
((i++))

echo "[$i/$n] installing prerequisites"
apt-get install gdebi-core build-dep python libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev -y
((i++))

echo "[$i/$n] downloading tarball"
tarball=Python-$version.tgz
wget https://www.python.org/ftp/python/$version/$tarball
((i++))

pythondir=$bin/python
echo "[$i/$n] unpacking tarball to $pythondir . . ."
[ -d $pythondir ] || mkdir $pythondir
tar -xzf $bin/$tarball -C $pythondir
((i++))

echo "[$i/$n] installing python"
cd $pythondir/Python-$version
./configure \
    --prefix=$pythondir \
    --enable-shared \
    --enable-optimizations \
    --enable-ipv6 \
    LDFLAGS=-Wl,-rpath=$pythondir/lib,--disable-new-dtags

make
make install
((i++))

echo "[$i/$n] installing pip . . ."
wget https://bootstrap.pypa.io/get-pip.py
$pythondir/$version/bin/python3 get-pip.py
((i++))

echo "[$i/$n] verifying installation"
$pythondir/$version/bin/python3 --version
((i++))

echo "[$i/$n] creating symbolic link"
ln -s $pythondir/bin/python3 /usr/bin/python3
((i++))

echo "[$i/$n] installation complete, initiating cleanup . . ."
rm $bin/$tarball ./get-pip.py --verbose
popd > /dev/null
echo "done"
