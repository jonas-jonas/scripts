#!/bin/sh

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get update
sudo apt-get install -y apt-transport-https

# Enable VSCode repo
curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# NodeJS
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -

# Dart
sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

sudo apt-get update
# Install apps
sudo apt-get install -y git zsh code tilix nodejs dart snapd

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"

# Sdkman
curl -s "https://get.sdkman.io" | bash

# Chrome
curl -os /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/chrome.deb
rm -f /tmp/chrome.deb

# fd-find
curl -o /tmp/fd-find.deb https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb
sudo dpkg -i /tmp/fd-find.deb
rm -f /tmp/fd-find.deb

# Setup symlinks to dart executables and hide the (error) output
sudo cp -s /usr/lib/dart/bin/* /usr/bin > /dev/null

# Install flatpak apps
sudo snap install slack --classic
sudo snap install spotify
sudo snap install telegram-desktop

# Install Java
#sdk install java

# Setup home folder structure
mkdir $HOME/Workspace
mkdir $HOME/Repositories
mkdir $HOME/Library

# Setup Spring tools
# TODO: Make this more generic to allow for easier version "upping"
curl -os /tmp/spring-tools.tar.gz http://download.springsource.com/release/STS4/4.1.1.RELEASE/dist/e4.10/spring-tool-suite-4-4.1.1.RELEASE-e4.10.0-linux.gtk.x86_64.tar.gz

tar -zxf /tmp/spring-tools.tar.gz -C $HOME/Library/
rm -rf /tmp/spring-tools.tar.gz
# Create desktop entry
cd $HOME/Library/sts-4.1.1.RELEASE
sudo bash -c 'cat <<EOF >/usr/share/applications/spring-tools.desktop
[Desktop Entry]
Name=Spring Tool Suite
Exec=$PWD/SpringToolSuite4
Icon=$PWD/icon.xpm
Terminal=false
Type=Application
StartupWMClass=Spring Tool Suite 4
EOF'
