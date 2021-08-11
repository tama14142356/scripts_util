#!/bin/bash
if [ "$#" -lt 2 ]; then
    echo "指定された引数は$#個です。" 1>&2
    echo "ポート番号とサーバ名を指定してください。" 1>&2
    exit 1
fi
remoteport="$1"
localport="$1"
servername="$2"
if [ "$#" -gt 2 ]; then
    remoteport="$2"
    servername="$3"
fi
is_open_browser=true
if [ "$#" -gt 3 ]; then
    is_open_browser="$4"
fi
ssh -N -f -L "$localport":localhost:"$remoteport" "$servername"
if "$is_open_browser"; then
    xdg-open http://localhost:"$localport"
fi
