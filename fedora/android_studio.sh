#!/bin/bash

#############
# VARIABLES #
#############

AS_VERSION="2021.1.1.21"
AS_DOWNLOAD_URL="https://dl.google.com/dl/android/studio/ide-zips/$AS_VERSION/android-studio-$AS_VERSION-linux.tar.gz"

##############
# RUN SCRIPT #
##############

echo -e "\n✓ Install Android Studio $AS_VERSION"

rm -rf /usr/local/android-studio
wget -O /tmp/android-studio.tar.gz $AS_DOWNLOAD_URL
tar -C /usr/local -xzf /tmp/android-studio.tar.gz
rm /tmp/android-studio.tar.gz

echo -e "\n✓ Install Google-recommended dependencies"

dnf install -y zlib.i686 ncurses-libs.i686 bzip2-libs.i686

echo -e "\n✓ Add Android Studio icon to GNOME Application list:"
echo -e "\t- Open Android Studio by '/usr/local/android-studio/bin/studio.sh' command"
echo -e "\t- Go to Tools > Create Desktop Entry"