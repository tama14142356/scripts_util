#!/bin/bash

file="$1"
cmd=${2:-"watch"}

wait_log "$file" "$cmd"

# func
wait_log() {
    file="$1"
    cmd=${2:-"watch"}

    while [ ! -e $file ]
    do
      sleep 1
    done

    if [ "$cmd" = "tail" ];then
        tail -f "$file"
    else
        watch -c -n 0.1 "less "$file" | tail -20"
    fi
}
