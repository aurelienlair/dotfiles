#!/usr/bin/env bash

dpkg -s snapd 2>/dev/null >/dev/null || sudo apt-get -y install snapd

sudo snap install phpstorm --classic
