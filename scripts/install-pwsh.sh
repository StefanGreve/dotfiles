#!/bin/bash

i=1
n=7
bin=/usr/local
arch=$(getconf LONG_BIT)
default="7.3.4"

pushd $bin > /dev/null
echo "[$i/$n] choose pwsh release (e.g. $default)"
read -p "version: " version
[ -z $version ] && version=$default
((i++))

echo "[$i/$n] updating system"
apt-get update
((i++))

echo "[$i/$n] installing prerequisites"
apt-get install libssl1.1 libunwind8 -y
((i++))

echo "[$i/$n] downloading tarball"
tarball=powershell-$version-linux-arm$arch.tar.gz
wget https://github.com/PowerShell/PowerShell/releases/download/v$version/$tarball
((i++))

pwshdir=$bin/powershell
echo "[$i/$n] unpacking tarball to $pwshdir . . ."
[ -d $pwshdir ] || mkdir $pwshdir
tar -xvf $bin/$tarball -C $pwshdir > /dev/null
((i++))

echo "[$i/$n] creating symbolic link"
ln -s $pwshdir/pwsh /usr/bin/pwsh
((i++))

echo "[$i/$n] installation complete, initiating cleanup . . ."
rm $bin/$tarball --verbose
popd > /dev/null
echo "done"
