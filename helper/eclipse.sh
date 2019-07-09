#!/bin/bash
echo "Downloading eclipse from $1"
curl --progress-bar -o /tmp/eclipse.tar.gz "$1"
echo "Finished downloading eclipse"

tar -zxf /tmp/eclipse.tar.gz -C $HOME/Library/
rm -rf /tmp/eclipse.tar.gz
# Create desktop entry
pushd $HOME/Library/eclipse
sudo bash -c 'cat <<EOF >/usr/share/applications/eclipse.desktop
[Desktop Entry]
Name=Eclipse
Exec=$PWD/eclipse
Icon=$PWD/icon.xpm
Terminal=false
Type=Application
StartupWMClass=eclipse
EOF'
popd
echo "Installed eclipse"
