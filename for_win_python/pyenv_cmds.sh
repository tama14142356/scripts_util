#!/bin/bash

pyenv () {
    cmd=${1:-"versions"}
    venv_name=${2:-"test_venv"}
    py_ver=${3:-"3.8"}
    venv_root=${4:-"$HOME/Documents/python_venvs"}

    if [ "$cmd" = "versions" ]; then
        venvs=$(find "$venv_root" -mindepth 1 -maxdepth 1 -type d)
        echo "Python version : venv_name"
        for venv_name in ${venvs};do
            # echo "$venv_name"
            py_cmd=${venv_name}/Scripts/python
            py_version=$(${py_cmd} -V)
            echo "$py_version"" : ""$(basename "$venv_name")"
        done
    elif [ "$cmd" = "venv" ] || [ "$cmd" = "virtualenv" ]; then
        if [ -d "$venv_root/$venv_name" ]; then
            venv_name="$venv_name""_copy"
        fi

        if type "py" > /dev/null 2>&1
        then
            py -"$py_ver" -m venv "$venv_root/$venv_name"
            venv_activate_rename_path "$venv_root/$venv_name"
        else
            echo "please install python for win"
        fi
    elif [ "$cmd" = "activate_adjust" ]; then
        venv_activate_rename_path "$venv_root/$venv_name"
    elif [ "$cmd" = "delete" ]; then
        if [ -d "$venv_root/$venv_name" ];then
            set -x
            rm -rf "$venv_root/$venv_name"
            set +x
        else
            echo "no found venv \"$venv_name\""
        fi
    fi

}

venv_activate_rename_path () {
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
    fi
}


# pyenv venv "test_venv_37" 3.7
# pyenv "versions"
# pyenv delete "ttt"
# pyenv delete "tmp_venv"
pyenv "$1" "$2" "$3" "$4"
