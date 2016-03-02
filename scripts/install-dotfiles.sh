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

    userFound="$(grep ^${username}: /etc/passwd)"
    if [ -n "${userFound}" ]; then
        path="/home/$username/"
        rm -rfv "$path.vim"
        cp -vr .vim "$path.vim"
        chown -Rv $username:$username "$path.vim"
        rm -fv "$path.vimrc"
        cp -v .vimrc "$path.vimrc"
        chown -v $username:$username "$path.vimrc"
        rm -fv "$path.tmux.conf"
        cp -v .tmux.conf "$path.tmux.conf"
        chown -v $username:$username "$path.tmux.conf"
        vim +PlugInstall +qall &> /dev/null
        chown -Rv $username:$username "$path.vim"
        #rm -fv "$path.bashrc"
        #cp -v .bashrc "$path.bashrc"
        #chown -v $username:$username "$path.bashrc"
    else
        echo -e "${RED}The user '$username' does not exist, skipping config...${Z}" 1>&2
        echo -e "\e[7mExit\e[0m"
        exit 1;
    fi
}

deploy_dotfiles
