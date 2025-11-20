#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ELECTRON_VERSION="37.0.0"
COLOR_BLUE='\033[3;34m'
COLOR_RESET='\033[0m'

#if [[ -f /usr/bin/claude-desktop ]]; then
#  echo -e "${COLOR_BLUE}Backing up claude-desktop launcher to '/usr/bin/claude-desktop.bkp'...${COLOR_RESET}"
#  sudo cp -f /usr/bin/claude-desktop /usr/bin/claude-desktop.bkp
#  sudo rm -f /usr/bin/claude-desktop
#fi

echo -e "${COLOR_BLUE}Build claude-desktop...${COLOR_RESET}"
${SCRIPT_DIR}/build-fedora.sh
source /tmp/claude-desktop-fedora-build.env

echo -e "${COLOR_BLUE}Force install claude-desktop...${COLOR_RESET}"
dnf install "$RPM_FILE"

if [[ ! -d /opt/electron/ ]]; then
  echo "${COLOR_BLUE}Installing dedicated electron v${ELECTRON_VERSION}...${COLOR_RESET}"
  cd /tmp
  wget https://github.com/electron/electron/releases/download/v${ELECTRON_VERSION}/electron-v${ELECTRON_VERSION}-linux-x64.zip
  mkdir -p /opt/electron
  unzip electron-v${ELECTRON_VERSION}-linux-x64.zip -d /opt/electron
  chmod +x /opt/electron/electron
  rm electron-v${ELECTRON_VERSION}-linux-x64.zip
fi

#echo -e "\n${COLOR_BLUE}Extract the app.asar...${COLOR_RESET}"
#cd /usr/lib64/claude-desktop/
#npx asar extract app.asar app-unpacked

#echo -e "${COLOR_BLUE}Enable native titlebar (updated pattern)...${COLOR_RESET}"
#sed -i 's/titleBarStyle:"hidden",show:Cpe||LG,/titleBarStyle:"default",show:Cpe||LG,/' app-unpacked/.vite/build/index.js

#echo -e "${COLOR_BLUE}Remove the overlay bar (updated variable name)...${COLOR_RESET}"
#sed -i 's/e2=Er?0:36/e2=0/g' app-unpacked/.vite/build/index.js

#echo -e "${COLOR_BLUE}Repack...${COLOR_RESET}"
#npx asar pack app-unpacked app.asar

echo -e "\n${COLOR_BLUE}Done.${COLOR_RESET}"
