#!/bin/bash

# Find email addresses for GitHub users.

set -o errexit
set -o pipefail

script="$(basename -- ${0})"
git_usr="$1"
out_file="$2"

usage() {
    echo "usage: ${script} [git_user] [out_file]"    
    exit 0
}

if [ "$#" -ne 2 ]; then
    usage
else
    wget -O "$out_file" https://api.github.com/users/"${git_usr}"/events/public &> /dev/null
    grep email "$out_file" | sort -u
    #grep login "$out_file" | sort -u
fi
