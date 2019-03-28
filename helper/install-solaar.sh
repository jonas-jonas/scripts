#!/bin/sh

git clone --depth=1 https://github.com/pwr/Solaar.git /tmp/Solaar

sudo mv /tmp/Solaar /usr/lib/Solaar

sudo ln -s /usr/lib/Solaar/bin/solaar /usr/bin/solaar

sudo cp /usr/lib/Solaar/share/applications/solaar.desktop /usr/share/applications

sh /usr/lib/Solaar/rules.d/install.sh