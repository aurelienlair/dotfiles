#!/usr/bin/env bash

curl -sSf https://sh.rustup.rs | sh
export PATH=$PATH:~/.cargo/bin
echo "Remember to add this command to your bashrc: export PATH=$PATH:~/.cargo/bin"
cargo install xsv
