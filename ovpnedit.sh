#!/bin/bash
#
# Edit the 'verbose' and 'script-security' configurations of the
# PIA OpenVPN config files

script_name="$(basename -- "$0")"
dir_input="$*"

usage() {
    echo -e "usage: "$script_name" [DIRECTORY]"
}

edit_config() {
    cd "$dir_input" || return

    for file in *.ovpn; do
        sed -i 's/verb 1/verb 3/g' "$file"
        (echo -e "\nscript-security 2"
         echo -e "up /etc/openvpn/update-resolv-conf"
         echo -e "down /etc/openvpn/update-resolv-conf") >> "$file"
    done
}

if [[ -d "$dir_input" && -r "$dir_input" ]]; then
    edit_config
else
    usage
fi
