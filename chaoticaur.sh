#!/bin/bash

G='\033[0;32m'
NC='\033[0m'

echo -e "${G}Checking for Chaotic-AUR...${NC}"

# 1. Check if already active
if grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo -e "${G}Chaotic-AUR already exists in pacman.conf.${NC}"
    sudo pacman -Syu
    exit
fi

# 2. Key import and mirror installation
echo -e "${G}Importing keys and installing mirrors...${NC}"
sudo pacman-key --recv-key 3056513887B78AEB --keyserver hkp://keyserver.ubuntu.com:80
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# 3. Append to pacman.conf
echo -e "${G}Adding repo to /etc/pacman.conf...${NC}"
echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf

# 4. Final Sync
echo -e "${G}Updating databases...${NC}"
sudo pacman -Syu

echo -e "${G}Done.${NC}"
