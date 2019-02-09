#!/bin/sh

# Enable google chrome repo
sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome

#Enable VSCode repo
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# NodeJS
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -

# Refresh dnf cache
sudo dnf check-update

# Install apps
sudo dnf install -y git zsh google-chrome-stable code tilix flatpak npm fd-find deja-dup

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Sdkman
curl -s "https://get.sdkman.io" | bash

# Node JS
sudo curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -

# Dart
curl -o /tmp/dart-sdk.zip https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip
sudo unzip -qq /tmp/dart-sdk.zip -d /usr/lib/
# Set permissions for all files in dart-sdk folder
sudo chmod -R 755 /usr/lib/dart-sdk/
rm -f /tmp/dart-sdk.zip

# Setup symlinks to dart executables and hide the (error) output
sudo cp -s /usr/lib/dart-sdk/bin/* /usr/bin > /dev/null

# Enable flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install flatpak apps
flatpak install -y flathub com.slack.Slack
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub org.telegram.desktop
flatpak install -y flathub org.mozilla.Thunderbird
flatpak install -y flathub com.discordapp.Discord

# Install Java
#sdk install java

# Setup home folder structure
mkdir $HOME/Workspace
mkdir $HOME/Repositories
mkdir $HOME/Library

# Setup Spring tools
# TODO: Make this more generic to allow for easier version "upping"
curl -o /tmp/spring-tools.tar.gz http://download.springsource.com/release/STS4/4.1.1.RELEASE/dist/e4.10/spring-tool-suite-4-4.1.1.RELEASE-e4.10.0-linux.gtk.x86_64.tar.gz

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
