#!/usr/bin/env bash
######################## Colors
export WHITE="\e[1;37m"
export LGRAY="\e[0;37m"
export GRAY="\e[1;30m"
export BLACK="\e[0;30m"
export RED="\e[0;31m"
export LRED="\e[1;31m"
export GREEN="\e[0;32m"
export LGREEN="\e[1;32m"
export YELLOW="\e[0;33m"
export BLUE="\e[0;34m"
export LBLUE="\e[1;34m"
export PURPLE="\e[0;35m"
export PINK="\e[1;35m"
export CYAN="\e[0;36m"
export LCYAN="\e[1;36m"
export Z="\e[0m"
##############################

if [ "$(id -u)" != "0" ]; then
   echo -e "${RED}This script must be run as root${Z}" 1>&2
   echo -e "${RED}exiting...${Z}" 1>&2
   exit 1
fi

function install_dialog() {
    apt-get install -y dialog < /dev/null || true;
}

command_exists() {
    command -v "$@" > /dev/null 2>&1
}
function installPygments() {
    sudo apt-get install -y python-pygments 
}
do_install() {
    if ! command_exists dialog; then
        install_dialog;
    fi

    cmd=(dialog --separate-output --checklist "Select program to install/configure:" 22 76 16)
    options=(1 "Dotfiles" off
            2 "Vim 8.0" off
            3 "Tmux 1.9a" off
            4 "Tmuxp" off
            5 "Pygments" off
            6 "Xsv" off
            7 "Docker" off
            8 "Mps" off
            9 "Postman" off
            10 "PHPStorm" off
            11 "Fish shell" off
            12 "Awscli" off
            13 "Vscode" off
            14 "Geany themes" off
            15 "Homebrew" off
            16 "Makecert" off
            17 "Shellcheck" off
            18 "Asdf" off
            19 "Node" off
            20 "InstantMarkDown" off
            21 "Yamllint" off
            22 "Pylint" off
            23 "Git configurations" off
    )
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
        case $choice in
            1)
                echo -e "${LGREEN}Configuring${Z} ${YELLOW}dotfiles${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-dotfiles.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            2)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Vim 8.0${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-vim-8.0.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            3)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Tmux 1.9a${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-tmux-1.9a.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            4)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}tmuxp${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-tmuxp.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            5)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Pygments${Z}"
                installPygments;
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            6)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}XSV${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-xsv.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            7)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Docker${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-docker.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            8)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}MPS${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-mps.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            9)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Postman${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-postman.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            10)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}PHPStorm${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-phpstorm.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            11)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Fish shell${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-fish.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            12)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Aws cli${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-awscli.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            13)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Vscode${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-vscode.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            14)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Geany themes${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-geany-themes.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            15)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Homebrew${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-homebrew.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            16)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Makecert${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-makecert.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            17)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Shellcheck${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-shellcheck.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            18)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Asdf${Z}"
                curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-asdf.sh | sudo -H -u aurelien /bin/bash
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            19)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Node${Z}"
                curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-node.sh | sudo -H -u aurelien /bin/bash
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            20)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Instant Markdown${Z}"
                curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-instant-markdown.sh | sudo -H -u aurelien /bin/bash
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            21)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Yamllint${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-yamllint.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            22)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Pylint${Z}"
                /bin/bash < <(curl -s https://raw.githubusercontent.com/aurelienlair/dotfiles/master/scripts/install-pylint.sh)
                echo -e "${LGREEN}...done${Z}\n"
                ;;
            23)
                echo -e "${LGREEN}Installing${Z} ${YELLOW}Git configurations${Z}"
                cp -v .git* /home/aurelien
                echo -e "${LGREEN}...done${Z}\n"
                ;;
        esac
    done
}

do_install
