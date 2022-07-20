#!/bin/bash
set -eux

old_year=${1:-"2021"}
new_year=$(($old_year + 1))

is_update=${2:-"update"}

tex_root="/usr/local/texlive"

cd "$tex_root"
sudo cp -a "$old_year" "$new_year"
sudo rm -rf "$new_year"/tlpkg/backups/*
# sudo rsync -ahv --exclude='tlpkg/backups' "$old_year/" "$new_year"
# sudo mkdir "$new_year/tlpkg/backups"

sudo tlmgr path remove
sudo "$tex_root/$new_year/bin/x86_64-linux/tlmgr" path add

sudo tlmgr version

cd "$new_year"

sudo wget http://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh
# sudo curl -L -O http://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh

sudo sh update-tlmgr-latest.sh -- --upgrade

if [ "$is_update" = "update" ];then
    sudo tlmgr update --self --all
fi
