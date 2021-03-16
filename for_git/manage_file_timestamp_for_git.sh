#!/bin/bash
if [ "$#" -gt 0 ]; then
    git init
    # shellcheck disable=SC2046,SC2012
    oldest_file_name=$(ls -1atrd $(find "$(pwd)" -type f -not -path "*/.git/*") | head -1)
    date_info=$(date -r "$oldest_file_name" '+%Y-%m-%dT%H:%M:%S%z')
    GIT_COMMITTER_DATE=\"$date_info\" git commit --allow-empty -m "first commit" --date "$date_info"
fi
root_dir_name=$(git rev-parse --show-toplevel)
pushd "$root_dir_name" || exit

# shellcheck disable=SC2046
old_file_list=$(ls -1atrd $(find "$root_dir_name" -type f -not -path "*/.git/*"))
for file in ${old_file_list}; do
    echo "$file"
    date_info=$(date -r "$file" '+%Y-%m-%dT%H:%M:%S%z')
    git add "$file"
    git_relative_path=$(git ls-files "$file" --full-name)
    if [ -f "$git_relative_path" ]; then
        GIT_COMMITTER_DATE=\"$date_info\" git commit -m "feat: add $git_relative_path" --date "$date_info"
    fi
done
popd || exit
