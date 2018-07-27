#!/bin/bash
#
# Edit the 'verbose' and 'script-security' configurations of the
# PIA OpenVPN config files

DIR_INPUT="$*"

usage_menu() {
    echo -e "usage: ${0} [DIRECTORY]"
}

edit_config() {
    cd "$DIR_INPUT" || return

    for file in *.ovpn; do
        sed -i 's/verb 1/verb 3/g' "$file"
        (echo -e "\nscript-security 2"
         echo -e "up /etc/openvpn/update-resolv-conf"
         echo -e "down /etc/openvpn/update-resolv-conf") >> "$file"
    done
}

if [[ -d "$DIR_INPUT" && -r "$DIR_INPUT" ]]; then
    edit_config
else
    usage_menu
fi
