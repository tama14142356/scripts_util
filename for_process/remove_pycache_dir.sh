#!/bin/bash
target_dir="."
if [ "$#" -gt 0 ]; then
    target_dir="$1"
fi
pycache_dir=$(find "$target_dir" -name "__pycache__")

for dir in ${pycache_dir}; do
    # echo "$pid"    #第一引数を表示
    echo "remove pycache dir:  $dir"
    rm -rf "$dir"
done
