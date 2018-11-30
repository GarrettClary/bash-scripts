#!/bin/bash

set -o errexit
set -o pipefail

# Edit the 'verbose' and 'script-security' configurations of the PIA OpenVPN config files

script_name="$(basename -- ${0})"
dir_input="$*"

usage() {
    echo "usage: ${script_name} [DIRECTORY]"
    exit
}

edit_config() {
    cd "$dir_input" || return

    for file in *.ovpn; do
        sed -i 's/verb 1/verb 3/g' "$file"
        (echo -e "\nscript-security 2"
         echo "up /etc/openvpn/update-resolv-conf"
         echo "down /etc/openvpn/update-resolv-conf") >> "$file"
    done
}

if [ "$#" -ne 1 ]; then
    usage
elif [ -d "$dir_input" ]; then
    edit_config
else
    usage
fi
