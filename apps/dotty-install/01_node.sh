#!/usr/bin/env bash
set -Eeo pipefail

# Install node via nvm
echo "Update NVM"
latest_nvm_release_url=$(curl --head --silent --write-out "%{redirect_url}\n" --output /dev/null https://github.com/nvm-sh/nvm/releases/latest)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${latest_nvm_release_url##*/}/install.sh | bash
echo "Load NVM"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ $(nvm current) == system ]]; then
  echo "Install node"
  nvm install --lts '/*'
else
  echo "Update node"
  nvm install --lts '/*' --reinstall-packages-from=node
fi
