#!/usr/bin/env bash

apt-get install build-essential -y
apt-get install curl -y
apt-get install file -y
apt-get install git -y

git clone https://github.com/Homebrew/brew /home/aurelien/.linuxbrew/Homebrew
mkdir /home/aurelien/.linuxbrew/bin
ln -s /home/aurelien/.linuxbrew/Homebrew/bin/brew /home/aurelien/.linuxbrew/bin
chown -vR aurelien:aurelien /home/aurelien/.linuxbrew
