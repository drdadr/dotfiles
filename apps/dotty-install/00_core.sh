#!/usr/bin/env bash
set -Euxo pipefail
SELFDIR=$(readlink -f $(dirname $0))
source ${SELFDIR}/install_library

# COLLECTION OF CORE PROGRAMMS TO INSTALL
# ============================================================================ #
# Git and tig
sudo apt install git
sudo apt install tig
# Python 3
sudo apt install python3
sudo apt install python3-dev
sudo apt install python3-pip
sudo apt install python3-venv
sudo apt install python3-setuptools
sudo apt install ipython3
# Python 2
sudo apt install python
sudo apt install python-dev
sudo apt install python-pip
sudo apt install python-venv
sudo apt install python-setuptools
sudo apt install ipython
# Linux utilities and essentials
sudo apt install stow
sudo apt install syslinux-utils
sudo apt install build-essential
sudo apt install checkinstall
sudo apt install remake
sudo apt install gdebi
sudo apt install rsync
sudo apt install tmux
# Linux cli tools
sudo apt install curl
sudo apt install vim
sudo apt install emacs
sudo apt install nmap

# Install node via nvm
latest_nvm_release_url=$(curl --head --silent --write-out "%{redirect_url}\n" --output /dev/null https://github.com/nvm-sh/nvm/releases/latest)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${latest_nvm_release_url##*/}/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if ! [ "$(nvm current)" == "system" ]; then
  nvm install --lts /*
else
  nvm install --lts /* --reinstall-packages-from=node
fi

# Better commnad history: https://github.com/dvorka/hstr
add_ppa ultradvorka/ppa
sudo apt-get install hstr
# Powerline fonts
sudo apt-get install fonts-powerline
