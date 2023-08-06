#!/bin/bash

set -eux

script_dir=$(
    cd "$(dirname "$0")" || exit 1
    pwd
)

venv_path="${1:-"$HOME/Documents/python_venvs/test_venv"}"
venv_path=$(
    cd "$venv_path" || exit 1
    pwd
)

win_venv_path=${venv_path//\//\\} # / -> \
win_venv_path=${win_venv_path#*\\} # \c\ -> c\
win_venv_path=${win_venv_path/c/C:} # c -> C:
win_venv_path=${win_venv_path//\\/\\\\} # \ -> \\

activate_sh_path="$venv_path/Scripts/activate"
# activate_sh_path="$(dirname "$venv_path")/activate"

s_str="VIRTUAL_ENV=\"""$win_venv_path""\""
l_str="VIRTUAL_ENV=\"""$venv_path""\""
add_str="# $s_str"
row_id=$(cat "$activate_sh_path" | grep -in "$s_str" | sed -e 's/:.*//g')
com_row_id=$(cat "$activate_sh_path" | grep -in "$add_str" | sed -e 's/:.*//g')
if [ -n "$com_row_id" ]; then
    set +e
    row_id=$(echo "$row_id" | grep -v "$com_row_id")
    set -e
fi

if [ -n "$row_id" ]; then
    sed -i -e ""$row_id"i $add_str" "$activate_sh_path"
    rep_row_id=$(($row_id + 1))

    sed -i -e ""$rep_row_id" s#${win_venv_path}#${venv_path}#g" "$activate_sh_path"
    # sed -e ""$rep_row_id" s/C/c/g" "$activate_sh_path"
fi
