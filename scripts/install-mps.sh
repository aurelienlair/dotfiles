#!/usr/bin/env bash

apt-get install vlc -y
apt-get install python3-pip -y
apt-get install python-setuptools -y
apt-get install python-dev -y

pip3 install --upgrade setuptools
pip3 install --upgrade --user mps-youtube
pip3 install --upgrade --user youtube-dl
