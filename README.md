# Bootstrap Scripts

This file contains useful scripts for setting up and maintaining a fedora installation.

## Scripts

The following section contains detailed descriptions on what each script does

### `setup`

The `setup` script sets up all kinds of defaults on a new Fedora installation. 
It is possible to use this script on other distributions but since Fedora uses the `dnf` package manager this is not recommended and will lead to errors.

#### Installed applications

The script installs the following applications if they're not available:

- Google Chrome
- Visual Studio Code
- Git
- zsh
- tilix
- flatpak
- fd-find
- NodeJS and NPM
- Dart Stable
- Slack
- Spotify
- Telegram
- Thunderbird
- Discord

### `dart-nightly`

The `dart-nightly` script installs the latest nightly build of the dart-sdk.
It also removes any existing installation of an older nightly build.

NOTE: Currently the location is hardcoded to $HOME/Library/dart-nightly.

