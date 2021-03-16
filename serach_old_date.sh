#!/bin/bash
# shellcheck disable=SC2012,SC2046
old_file_name=$(ls -1atrd $(find "$(pwd)" -type f) | head -1)
# shellcheck disable=SC2012,SC2046
old_directory_name=$(ls -1atrd $(find "$(pwd)" -type d) | head -1)
echo "$old_directory_name"
date -r "$old_directory_name" '+%Y-%m-%dT%H:%M:%S%z'
echo "$old_file_name"
date -r "$old_file_name" '+%Y-%m-%dT%H:%M:%S%z'
