#!/usr/bin/env bash
set -Eeuo pipefail
# INSTALL APPS FOR MOBIUS
# ============================================================================ #

# APT INSTALLS
sudo apt install cmake
sudo apt install byobu

# NPM INSTALL
source $HOME/.nvm/nvm.sh
nvm use node
npm install -g coffeescript@1.9.3
npm install -g prettier
npm install -g json-diff
