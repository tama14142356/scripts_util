#!/bin/bash

file="$1"

while [ ! -e $file ]
do
  sleep 1
done

# tail -f "$file"
watch -c -n 0.1 "less "$file" | tail -20"
