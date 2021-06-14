#!/usr/bin/env bash
set -Eeo pipefail
SELFDIR=$(readlink -f $(dirname $0))
source ${SELFDIR}/install_library

if command -v pandoc &> /dev/null; then
  CUR_VERSION="$(pandoc --version | head -n1 | cut -d " " -f2)"
else
  CUR_VERSION=""
fi
NEW_VERSION="$(curl -s https://api.github.com/repos/jgm/pandoc/releases/latest | grep tag_name | cut -d ':' -f2 | cut -d '"' -f2)"

echo "Current Pandox Version: $CUR_VERSION => New Pandox Version: $NEW_VERSION"

if [ "$NEW_VERSION" != "$CUR_VERSION" ]; then

  echo "Installing version $NEW_VERSION"
  install_deb "$(ghrelease jgm pandoc 'amd64.deb')"

  VERSION="$(pandoc --version | head -n1 | cut -d " " -f2)"
  echo "New Pandoc version installed!: $VERSION"

else
  echo "Latest version already installed"
fi
