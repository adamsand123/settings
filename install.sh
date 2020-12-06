#!/usr/bin/env bash
PACKAGE_FILE="$(pwd)"/package_list.txt

FORMAT="\e[0m"
BOLD="\e[1m"
RED="$BOLD\e[31m"
GREEN="$BOLD\e[32m"
BLUE="$BOLD\e[34m"

apt_install()
{
  command -v "$line" &>/dev/null
  if [ $? -eq 1 ] ; then
    echo -e "$BLUE"Trying to install "$line" with: sudo apt install "$line""$FORMAT"
    sudo apt install "$line" -y && echo -e "$GREEN""$line" was successfully installed"$FORMAT" || echo -e "$RED"ERROR installing "$line" with apt install"$FORMAT"
  else
    echo -e "$BLUE""$line" is already installed skipping."$FORMAT"
  fi
}

sudo apt update -y || echo -e "$RED"Failed to update repos"$FORMAT"
sudo apt upgrade -y || echo -e "$RED"Failed to upgrade packages"$FORMAT"

while read -r line ; do
  apt_install
  if [[ $? -ne 0 ]] ; then
    echo -e "$RED"Function apt_install failed to run"$FORMAT"
    exit 1
  fi
done < "$PACKAGE_FILE"

tldr -u
