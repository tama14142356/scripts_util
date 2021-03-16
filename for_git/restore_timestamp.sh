#!/bin/bash
git_files=$(git ls-files)

for FILE in ${git_files}; do
    TIME=$(git log --pretty=format:%ci -n1 "$FILE")
    printf '%s\t%s\n' "$TIME" "$FILE"
    STAMP=$(date -d "$TIME" +"%y%m%d%H%M.%S")
    touch -t "$STAMP" "$FILE"
done
