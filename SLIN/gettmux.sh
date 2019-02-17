#!/bin/bash
RED='\e[0;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: This script must be run as root${NC}" >&2
   exit 1
fi
echo -e "${BLUE}INFO: Installing tmux${NC}"
yum install -y tmux
echo -e "${BLUE}INFO: Downloading tmux config file${NC}"
wget -O /root/.tmux.conf https://raw.githubusercontent.com/PotatoDrug/dotfiles/master/tmuxconf
echo -e "${BLUE}INFO: Adding config file to all user directories${NC}"
for homedir in /home/*/
    do cp /root/.tmux.conf "$homedir"
done
echo -e "${GREEN}Success: Tmux installed and configured!${NC}"