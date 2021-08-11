#!/bin/bash
SCRIPT_DIR=$(
    cd "$(dirname "$0")" || exit
    pwd
)
background_process=$(bash "$SCRIPT_DIR"/pgrep_name.sh "ssh -N")
if [ "$#" -gt 0 ]; then
    background_process=$(bash "$SCRIPT_DIR"/pgrep_name.sh "$1" "ssh -N")
fi

for pid in ${background_process}; do
    # echo "$pid" #第一引数を表示
    localport=$(ps -o args= --pid "$pid" | tr " " "\n" | grep ":" | tr ":" "\n" | head -1)
    echo "open browser: "
    ps -o user=,pid=,args= --pid "$pid"
    xdg-open http://localhost:"$localport"
done
