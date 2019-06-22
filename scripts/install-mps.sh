#!/usr/bin/env bash

apt-get install vlc -y
apt-get install python3-pip -y
apt-get install python-setuptools -y
apt-get install python-dev -y
apt-get install python3-setuptools


pip3 uninstall wheel --yes
pip3 uninstall setuptools --yes

pip3 install --upgrade wheel
pip3 install --upgrade setuptools

su - aurelien -c 'pip3 uninstall mpsyt --yes'
su - aurelien -c 'pip3 uninstall youtube-dl --yes'

git -C /tmp/ clone git@github.com:mps-youtube/mps-youtube.git
cd /tmp/mps-youtube

su - aurelien -c 'pip3 install --upgrade --user /tmp/mps-youtube'
su - aurelien -c 'pip3 install --upgrade --user youtube-dl'

rm -rf /tmp/mps-youtube
