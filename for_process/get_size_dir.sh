#!/bin/bash
# du "$1" -hc --exclude anaconda3 | sort -rn | head -10
# du -d1 -hc --apparent-size "$1" --exclude "$2" | sort -rn | head -10
du -d1 -hc --apparent-size "$1" | sort -rn | head -10
