#!/bin/bash
sudo apt-get install -y libevent-dev libncurses-dev pkg-config

cd /tmp
rm -rf tmux-1.9a
rm -rf tmux-1.9a.tar.gz
wget "https://github.com/tmux/tmux/releases/download/1.9a/tmux-1.9a.tar.gz"
tar xvzf tmux-1.9a.tar.gz
cd tmux-1.9a

autoreconf -fis
./configure

make
sudo make install
