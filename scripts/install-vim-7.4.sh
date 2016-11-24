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
