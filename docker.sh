#!/bin/bash

if [ $(command -v docker) ]; then
	sudo apt --purge autoremove docker docker-engine docker.io containerd runc
fi


# check dist
if [ $(uname -a | grep -i ubuntu) ]; then
	sudo apt update && sudo apt install software-properties-common gnupg2 curl ca-certificates apt-transport-https
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
else
	sudo apt update && sudo apt install software-properties-common apt-transport-https ca-certificates curl gnupg2
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
fi
sudo apt update && sudo apt install docker-ce
sudo apt install docker-compose
sudo adduser $USER docker
