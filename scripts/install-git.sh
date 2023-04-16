#!/bin/bash

i=1
n=8
bin=/usr/local
default="2.39.2"

pushd $bin > /dev/null
echo "[$i/$n] choose git release (e.g. $default)"
read -p "version: " version
[ -z $version ] && version=$default
((i++))

echo "[$i/$n] updating system"
apt-get update
((i++))

echo "[$i/$n] installing prerequisites"
apt-get install libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake gcc -y
((i++))

echo "[$i/$n] downloading tarball"
tarball=git-$version.tar.gz
wget https://mirrors.edge.kernel.org/pub/software/scm/git/$tarball
((i++))

gitdir=$bin/git
echo "[$i/$n] unpacking tarball to $gitdir . . ."
[ -d $gitdir ] || mkdir $gitdir
tar -xvf $bin/$tarball -C $gitdir > /dev/null
((i++))

echo "[$i/$n] installing git"
cd $gitdir/git-$version
make prefix=$gitdir all
make prefix=$gitdir install
((i++))

echo "[$i/$n] creating symbolic link"
ln -s $gitdir/bin/git /usr/bin/git
((i++))

echo "[$i/$n] installation complete, initiating cleanup . . ."
rm $bin/$tarball --verbose
popd > /dev/null
echo "done"
