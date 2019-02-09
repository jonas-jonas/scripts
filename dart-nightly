# Curl the latest nightly build into the /tmp folder
echo "Getting latest nightly build"
curl -o /tmp/dart-nightly.zip http://commondatastorage.googleapis.com/dart-archive/channels/be/raw/latest/sdk/dartsdk-linux-x64-release.zip

# Remove any existing dart-nightly installation from the Library folder
rm -rf $HOME/Library/dart-nightly

# Unzip the archive to a tmp location. This is because in the archive is
# another folder called "Dart-sdk". It should be possible to have an
# unrelated folder in ~/Library called dart-sdk. If this wasn't extracted
# into the tmp location it would be overriden/removed.
echo "Unzipping..."
unzip -qq /tmp/dart-nightly.zip -d /tmp/dart-tmp

# Move the extracted contents to the Library folder
mv /tmp/dart-tmp/dart-sdk $HOME/Library/dart-nightly

# Remove any artifacts from the /tmp folder
rm -rf /tmp/dart-nightly.zip /tmp/dart-tmp

