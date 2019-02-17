#!/bin/bash
RED='\e[0;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: This script must be run as root${NC}" >&2
   exit 1
fi
echo -e "${BLUE}Info: Installing python3.6${NC}"
yum install -y epel-release && yum install -y python36
echo -e "${BLUE}Info: Linking python3.6 to python3${NC}"
ln -s /usr/bin/python3.6 /usr/bin/python3
if ! [ -x "$(command -v python3)" ]
then
    echo -e "${RED}Error: Python3.6 Installation failed.${NC}" >&2
    exit 1
else
    echo -e "${GREEN}Python3.6 Installed.${NC}"
    exit 0
fi