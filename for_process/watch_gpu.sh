#!/bin/bash
SCRIPT_DIR=$(
    cd "$(dirname "$0")" || exit
    pwd
)
server_name="$1"
is_open_browser=true
if [ "$#" -gt 1 ]; then
    is_open_browser=false
fi
localport=1080
remoteport=1080
bash "$SCRIPT_DIR"/port_forward.sh "$localport" "$remoteport" "$server_name" "$is_open_browser"
