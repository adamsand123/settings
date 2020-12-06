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
    clear
    if [[ $? -ne 0 ]] ; then
        echo -e "$RED"Function apt_install failed to run"$FORMAT"
        exit 1
    fi
done < "$PACKAGE_FILE"

export EDITOR=vim
echo "export EDITOR=vim" >> ~/.profile
echo "export EDITOR=vim" >> ~/.bashrc
echo "export EDITOR=vim" >> ~/.zshrc
echo "set -o vi" >> ~/.bashrc
echo "bindkey -v" >> ~/.zshrc

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

echo -e "$BLUE"Trying to update tldr"$FORMAT"
tldr -u && echo -e "$GREEN"tldr successfully updated"$FORMAT" || echo -e "$RED"Error updating tldr"$FORMAT"
clear

echo -e "$BLUE"Trying to update tldr"$FORMAT"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && echo -e "$RED"Error installing oh-my-zsh"$DEFAULT"
clear
