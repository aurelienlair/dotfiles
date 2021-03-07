#!/usr/bin/env bash
set -e -o pipefail

su aurelien -c 'git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0'

# Remove with the following commands
#. $HOME/.asdf/asdf.sh
#. $HOME/.asdf/completions/asdf.bash
