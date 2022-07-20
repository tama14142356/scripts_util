#!/bin/bash
set -eux

gui=${1:-"nogui"}
if [ "$gui" = "gui" ];then
    sudo apt install tcl tk -y
fi

is_installed=$(find /usr/local -name "texlive")
if [ -n "$is_installed" ];then
    echo "you have already installed texlive!!"
    exit 1
fi

basepath=$(basename "$0")
timestamp=$(date '+%Y%m%d%H%M%S')
tmpd=$(mktemp -dt "$basepath.$timestamp.$$")

pushd "$tmpd"

wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvf install-tl-unx.tar.gz

pushd install-tl-2*
sudo ./install-tl -no-gui
popd

popd

sudo /usr/local/texlive/????/bin/*/tlmgr path add
