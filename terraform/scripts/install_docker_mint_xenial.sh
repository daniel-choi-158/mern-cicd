#!/bin/bash

# Uninstall old version
sudo apt-get remove docker docker-engine docker.io
# Update apt package index
sudo apt-get update
# Install packages to allow apt to use a repo over HTTPS
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
# Add Docker offical GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Verify you have the key with fingerprint 
# 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88 by
# searching the last 8 characters of the fingerprint
sudo apt-key fingerprint 0EBFCD88
# Expected output:
# pub   4096R/0EBFCD88 2017-02-22
#      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
#      uid                  Docker Release (CE deb) <docker@docker.com>
#      sub   4096R/F273FCD8 2017-02-22

# Use the next command to set up the stable repo
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
# Update the apt package index
sudo apt-get update
# Install latest docker ce
sudo apt-get install docker-ce -y
# Verify docker ce is installed correctly
sudo docker run hello-world
# Install compose
 sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# Apply executable permissions to the binary
 sudo chmod +x /usr/local/bin/docker-compose
# Test the installation
# Expected output: docker-compose version [version], build [build]
 docker-compose --version
# add current localuser to group "docker"
 sudo usermod -aG docker `echo $USER`