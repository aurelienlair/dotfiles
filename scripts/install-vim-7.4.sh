#!/bin/bash
function installVim() {
    sudo apt-get install -y lua5.1 liblua5.1-dev libncurses5-dev libgnome2-dev \
        libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev \
        libx11-dev libxpm-dev libxt-dev python-dev ruby-dev wget

    mkdir -p /tmp/install
    cd /tmp/install
    rm -rf vim74
    wget ftp://ftp.de.vim.org/unix/vim-7.4.tar.bz2
    tar xvjf vim-7.4.tar.bz2
    cd vim74

    ./configure --with-features=huge \
                --enable-gui=gtk2 \
                --enable-cscope \
                --prefix=/usr \
                --enable-luainterp \
                --with-lua-prefix=/usr \
                --enable-pythoninterp \
                --enable-rubyinterp

    make VIMRUNTIMEDIR=/usr/share/vim/vim74
    sudo make install
}

installVim;
exit $?
