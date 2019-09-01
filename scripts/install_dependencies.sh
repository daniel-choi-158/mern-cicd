#!/bin/bash

#installs standard required package managers (pip and yum)

sudo apt-get update -y
sudo apt-get install -yq build-essential python-pip rsync
sudo apt-get install yum -y
sudo yum update -y