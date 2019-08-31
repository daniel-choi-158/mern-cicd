#!/bin/bash

sudo usermod -aG docker `echo $USER`
sudo docker run -d -p 80:80 nginx