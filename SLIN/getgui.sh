#!/bin/bash
RED='\e[0;31m'
NC='\e[0m'
if [[ $EUID -ne 0 ]]; then
	echo -e "${RED}Error: This script must be run as root${NC}" >&2
	exit 1
fi
yum groupinstall -y "GNOME Desktop" "Graphical Administration Tools"
ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
echo "Reboot for changes to take effect"
