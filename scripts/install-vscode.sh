#!/usr/bin/env bash

dpkg -s snapd 2>/dev/null >/dev/null || apt-get -y install snapd

snap install code --classic

# Dotnet (if necessary especially when not using containers)
# https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/sdk-2.2.203
#wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
#dpkg -i packages-microsoft-prod.deb
#
#add-apt-repository universe
#apt-get install -y apt-transport-https
#apt-get update
#apt-get install -y dotnet-sdk-2.2.203=2.2.203-1

