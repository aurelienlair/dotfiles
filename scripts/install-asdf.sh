#!/usr/bin/env bash
set -e -o pipefail

git clone https://github.com/asdf-vm/asdf.git "${HOME}/.asdf" --branch v0.8.0

# Remove with the following commands
#rm -rf ${ASDF_DATA_DIR:-$HOME/.asdf} ~/.tool-versions
