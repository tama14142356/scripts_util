#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "指定された引数は$#個です。" 1>&2
    echo "サーバー名とユーザ名を指定してください。" 1>&2
    exit 1
fi
sever_name="$1"
user_name="$2"
mkdir mount
sshfs "$server_name":/home/"$user_name" mount/
