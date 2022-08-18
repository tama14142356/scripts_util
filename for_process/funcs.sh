#!/bin/bash

on_tmux() {
    tmux_name="$1"
    cwd_path=${2:-"$(pwd)"}
    is_on_code_tmux=$(tmux ls 2> /dev/null | grep "$tmux_name")
    if [ -n "$is_on_code_tmux" ];then
        tmux a -t "$tmux_name"
    else
        cd "$cwd_path"
        tmux new -s "$tmux_name"
    fi
}

pycache_clean(){
    set -x
    tar_dir=${1:-"$(pwd)"}
    pushd "$tar_dir"
    pycache_dirs=$(find "$tar_dir" -type d -name "__pycache__")
    for d in ${pycache_dirs};
    do
        rm -rf "$d"
    done
    popd
    set +x
}
