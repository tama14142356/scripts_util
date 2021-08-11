#!/bin/bash
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "指定された引数は$#個です。" 1>&2
    echo "コマンド名を1つだけ指定してください。" 1>&2
    echo "または、オプション名とコマンド名を指定してください。" 1>&2
    exit 1
fi
SCRIPT_DIR=$(
    cd "$(dirname "$0")" || exit
    pwd
)
background_process=$(bash "$SCRIPT_DIR"/pgrep_name.sh "$1")
if [ "$#" -gt 1 ]; then
    background_process=$(bash "$SCRIPT_DIR"/pgrep_name.sh "$1" "$2")
fi

for pid in ${background_process}; do
    # echo "$pid"    #第一引数を表示
    echo 'kill process: '
    ps -o user=,pid=,args= --pid "$pid"
    kill "$pid"
done
