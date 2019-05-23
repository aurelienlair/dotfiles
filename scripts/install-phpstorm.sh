#!/usr/bin/env bash

dpkg -s snapd 2>/dev/null >/dev/null || apt-get -y install snapd

snap install phpstorm --classic
