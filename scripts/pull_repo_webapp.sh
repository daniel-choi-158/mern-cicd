#!/bin/bash

# pull from Github
export APPDIR=/app/

sudo mkdir $APPDIR
cd $APPDIR
sudo git clone https://github.com/daniel-choi-158/mern-webapp.git
sudo chown -R dchoi5 .