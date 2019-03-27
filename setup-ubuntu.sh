#!/bin/sh

# Get the latest release of a github repository
# Usage: get_latest_release "repo_owner/repo"
get_latest_release() {
    echo $(curl -s "https://api.github.com/repos/$1/tags?per_page=1" | grep '"name":' | sed -E 's/.*"([^"]+)".*/\1/')
}

# Update registry
sudo apt-get -qq update
# Upgrade already installed libraries
sudo apt-get -yq upgrade

# Install apt-transport-https for downloading apt packages via https
sudo apt-get install -y apt-transport-https curl

# Enable VSCode repo
curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm microsoft.gpg

# NodeJS
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Dart
sudo sh -c 'curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'curl -s https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

sudo apt-get -qq update
# Install apps
sudo apt-get install -y git zsh code tilix nodejs dart snapd unzip google-chrome-stable

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"

# Sdkman
curl -s "https://get.sdkman.io" | bash

# fd-find
curl -sLo /tmp/fd-find.deb https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb
sudo dpkg -i /tmp/fd-find.deb
rm -f /tmp/fd-find.deb

echo "Installing snaps"
# Install flatpak apps
sudo snap install slack --classic
sudo snap install spotify
sudo snap install telegram-desktop

echo "Finished installing snaps"

# Setup home folder structure
mkdir $HOME/Workspace
mkdir $HOME/Repositories
mkdir $HOME/Library

# Setup Spring tools
echo "Downloading Spring Tool Suite"
curl -so /tmp/spring-tools.tar.gz "https://download.springsource.com/release/STS4/4.1.2.RELEASE/dist/e4.10/spring-tool-suite-4-4.1.2.RELEASE-e4.10.0-linux.gtk.x86_64.tar.gz"
echo "Finished downloading Spring Tool Suite"

tar -zxf /tmp/spring-tools.tar.gz -C $HOME/Library/
rm -rf /tmp/spring-tools.tar.gz
# Create desktop entry
cd $HOME/Library/sts-4.1.2.RELEASE
sudo bash -c 'cat <<EOF >/usr/share/applications/spring-tools.desktop
[Desktop Entry]
Name=Spring Tool Suite
Exec=$PWD/SpringToolSuite4
Icon=$PWD/icon.xpm
Terminal=false
Type=Application
StartupWMClass=Spring Tool Suite 4
EOF'

# Download MONONOKI font
MONONOKI_VERSION=$(get_latest_release "madmalik/mononoki")
curl -sLo /tmp/mononoki.zip "https://github.com/madmalik/mononoki/releases/download/$MONONOKI_VERSION/mononoki.zip"

unzip -qq /tmp/mononoki.zip -d /tmp/mononoki
rm -rf /tmp/mononoki.zip
sudo mkdir -p /usr/share/fonts/truetype
sudo cp /tmp/mononoki/*.ttf /usr/share/fonts/truetype
fc-cache

# sudo gsettings set org.gnome.desktop.interface monospace-font-name 'Mononoki Bold 12'
