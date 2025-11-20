#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COLOR_BLUE='\033[3;34m'
COLOR_RESET='\033[0m'
#ELECTRON_VERSION="37.0.0"

#if [[ -f /usr/bin/claude-desktop ]]; then
#  echo -e "${COLOR_BLUE}Backing up claude-desktop launcher to '/usr/bin/claude-desktop.bkp'...${COLOR_RESET}"
#  sudo cp -f /usr/bin/claude-desktop /usr/bin/claude-desktop.bkp
#  sudo rm -f /usr/bin/claude-desktop
#fi

echo -e "${COLOR_BLUE}Build claude-desktop...${COLOR_RESET}"
${SCRIPT_DIR}/build-fedora.sh
source /tmp/claude-desktop-fedora-build.env

echo -e "${COLOR_BLUE}Install claude-desktop...${COLOR_RESET}"
dnf install -y "$RPM_FILE"

echo -e "\n${COLOR_BLUE}Done.${COLOR_RESET}"
