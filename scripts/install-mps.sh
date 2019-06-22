#!/usr/bin/env bash

apt-get install vlc -y
apt-get install python3-pip -y
apt-get install python-setuptools -y
apt-get install python-dev -y
apt-get install python3-setuptools


pip3 uninstall wheel
pip3 uninstall setuptools

pip3 install --upgrade wheel
pip3 install --upgrade setuptools

su aurelien

pip3 uninstall mpsyt
pip3 uninstall youtube-dl

git -C /tmp/ clone git@github.com:mps-youtube/mps-youtube.git
cd /tmp/mps-youtube

pip3 install --upgrade --user .
pip3 install --upgrade --user youtube-dl
