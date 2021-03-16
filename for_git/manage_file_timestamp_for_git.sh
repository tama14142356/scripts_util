#!/bin/bash
IFS=$'\n'
root_dir=$(git rev-parse --show-toplevel 2> tmp.txt)
rm tmp.txt
if [ -z "$root_dir" ]; then
    git init
fi
pushd "$root_dir" || exit
file_list=$(find "$(pwd)" -type f -not -path "*/.git/*")
is_first_commit=$(git branch)
if [ -z "$is_first_commit" ]; then
    # shellcheck disable=SC2086,2012
    oldest_file_name=$(ls -1atrd $file_list | head -1)
    date_info=$(date -r "$oldest_file_name" '+%Y-%m-%dT%H:%M:%S%z')
    GIT_COMMITTER_DATE=\"$date_info\" git commit --allow-empty -m "first commit" --date "$date_info"
fi
# shellcheck disable=SC2086
old_file_list=$(ls -1atrd $file_list)
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
