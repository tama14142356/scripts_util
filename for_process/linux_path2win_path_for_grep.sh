#!/bin/bash

set -eu

script_dir=$(
    cd "$(dirname "$0")" || exit 1
    pwd
)

linux_path="${1:-"$HOME/test_win_path"}"
linux_path=$(
    cd "$linux_path" || exit 1
    pwd
)

win_path=${linux_path//\//\\} # / -> \
win_path=${win_path#*\\} # \c\ -> c\
win_path=${win_path/c/C:} # c -> C:
win_path=${win_path//\\/\\\\} # \ -> \\

echo "$win_path"

# use this script when following action
# cat "$file" | grep "$win_path"
