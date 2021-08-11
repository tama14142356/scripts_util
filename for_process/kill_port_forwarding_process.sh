#!/bin/bash
SCRIPT_DIR=$(
    cd "$(dirname "$0")" || exit
    pwd
)
bash "$SCRIPT_DIR"/kill_process_from_name.sh "ssh -N"
