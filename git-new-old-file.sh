#!/bin/bash

# Auther: zhengqingquan
# 
# Instructions
# This script has two parameters, the hash of two commit records.
# It will generate the new and old files between the two commit records.
# 
# For example:
# $ ./git-new-old-file.sh 939341c34897f0a018b396493f8bb3389f806048 de4d0c34f3db018fe807b3834b91ef938fa62cc8
# or
# $ ./git-new-old-file.sh 939341c34897f0a018b396493f8bb3389f806048^ de4d0c34f3db018fe807b3834b91ef938fa62cc8

commit_hash_start=$1
commit_hash_end=$2
declare -p commit_hash_start commit_hash_end

git_cmd="git show --pretty="" --name-only $commit_hash_start..$commit_hash_end"
echo git_cmd:$git_cmd

changes_files=$($git_cmd)
echo change:
echo "$changes_files"

# Traverse every line in changes_files and save the content of each line in the file variable.
echo oldfile：
while IFS= read -r file; do
    # Check if the file exists in the parent commit (old version)
    if git show $commit_hash_start:./"$file" &> /dev/null; then
        mkdir -p patch/old/"$(dirname "$file")"
        git show "$commit_hash_start":"$file" > patch/old/"$file"
        echo "$file":old yes
    else
        echo "$file":old no
    fi

    # Check if the file exists in the current commit (new version)
    if git show $commit_hash_end:./"$file" &> /dev/null; then
        mkdir -p patch/new/"$(dirname "$file")"
        cp -r --parents "$file" patch/new/
        echo "$file":new yes
    else
        echo "$file":new no
    fi
done <<< "$changes_files"
