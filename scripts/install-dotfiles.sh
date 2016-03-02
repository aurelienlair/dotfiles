#!/usr/bin/env /bin/bash
export RED="\e[0;31m"

function install_dialog() {
    apt-get install -y dialog < /dev/null || true;
}

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

deploy_dotfiles() {
    if ! command_exists dialog; then
        install_dialog;
    fi

    t=$(mktemp -t inputbox.XXXXXXXX) || exit
    trap 'rm -f "$t"' EXIT         # remove temp file when done
    trap 'exit 127' HUP STOP TERM  # remove if interrupted, too
    dialog --inputbox \
        "For which username do you want to set this configuration?" 0 0 2>"$t"
    retval=$?
    username=$(cat "$t");
    case $retval in
      0)    echo "Username chosen is '$username'";;
      1)    echo "Cancel pressed. Skipping config..."; echo -e "\e[7mExit\e[0m"; exit 1;
    esac 
    clear
    userFound=false
    getent passwd $username >/dev/null 2>&1 && userFound=true
    
    if $userFound; then
        git submodule update -i
        rm -rfv /$username/.vim
        cp -v .vim /$username/.vim
        rm -rfv /$username/.vimrc
        cp -v .vimrc /$username/.vimrc
        vim +PluginInstall +qall
        #rm -rfv /$username/.bashrc
        #cp -v .bashrc /$username/.bashrc
        cp -v .tmux.conf /$username/.tmux.conf
    else
        echo -e "${RED}The user '$username' does not exist, skipping config...${Z}" 1>&2
        echo -e "\e[7mExit\e[0m"
        exit 1;
    fi
}

deploy_dotfiles
