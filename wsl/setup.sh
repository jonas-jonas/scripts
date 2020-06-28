#!/bin/sh

# Update registry
sudo apt-get -qq update
# Upgrade already installed libraries
sudo apt-get -yq upgrade

# Install apt-transport-https for downloading apt packages via https
sudo apt-get install -y apt-transport-https curl

# NodeJS
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get -qq update
# Install apps
sudo apt-get install -y git zsh nodejs unzip

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"

# fd-find
curl -sLo /tmp/fd-find.deb https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb
sudo dpkg -i /tmp/fd-find.deb
rm -f /tmp/fd-find.deb

# Deno
curl -fsSL https://deno.land/x/install/install.sh | sh
echo "export DENO_INSTALL=\"/home/jonas/.deno\"" >> $HOME/.zshrc
echo "export PATH=\"$DENO_INSTALL/bin:$PATH\"" >> $HOME/.zshrc
echo "export DOCKER_HOST=tcp://localhost:2375" >> $HOME/.zshrc
echo "export PATH=\"$PATH:$HOME/.yarn/bin\"" >> $HOME/.zshrc
