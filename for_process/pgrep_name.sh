#!/bin/bash
if [ "$#" -lt 1 ] || [ "$#" -gt 3 ]; then
    echo "指定された引数は$#個です。" 1>&2
    echo "コマンド名を1つだけ指定してください。" 1>&2
    echo "または、オプション名とコマンド名を指定してください。" 1>&2
    exit 1
fi

user_name="$3"
if [ -z "$user_name" ]; then
    user_name="$(whoami)"
fi

process=$(pgrep -u "$user_name" -f "$1")
if [ "$#" -gt 1 ]; then
    process=$(pgrep -u "$user_name" "$1" "$2")
fi

# bashファイル起動によるコマンドの除外
bash_process=$(pgrep -u "$user_name" -f "bash")
for pid in ${bash_process}; do
    process=$(echo "$process" | grep -v "$pid")
done

echo "$process"
