#!/usr/bin/env bash
set -e -o pipefail

bash -c "asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git"
bash -c "${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring"
bash -c "asdf install nodejs latest:12"
bash -c "asdf global nodejs 12.21.0"

