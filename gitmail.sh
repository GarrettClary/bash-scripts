#!/bin/bash

git_usr=$1
out_file=$2

script=(basename -- "${0}")

usage() {
    echo -e "usage: ${script} [git_user] [out_file]"    
}

if [ "$#" -ne 2 ]; then
    usage
else
    wget -O "$out_file" https://api.github.com/users/"${git_usr}"/events/public &> /dev/null
    grep email "$out_file" | sort -u
fi
