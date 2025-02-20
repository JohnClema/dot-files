#!/bin/bash

# Install APT packages
cat packages.txt | xargs sudo apt install -y

# WORKAROUND: Install bat from local binary (to get later version)
#  See: https://github.com/sharkdp/bat/blob/master/README.md#installation
if ! [ -x "$(command -v bat)" ]; then
  curl -LO https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb
  sudo dpkg -i bat_0.17.1_amd64.deb
  rm -f bat_0.17.1_amd64.deb
fi

# FIXUP: Alias fdfind to fd
if ! [ -x "$(command -v fd)" ]; then
  mkdir -p ~/.local/bin
  ln -s /usr/bin/fdfind ~/.local/bin/fd
fi

# WORKAROUND: Install ripgrep with flags to override installation bug
#  See: https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517
if ! [ -x "$(command -v rg)" ]; then
  apt download ripgrep
  sudo dpkg --force-overwrite -i ripgrep*.deb
  rm -f ripgrep*.deb
fi

# WORKAROUND: Install fzf from local submodule source (to get later version)
./fzf/install --all
