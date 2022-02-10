#!/bin/bash

USERNAME="koddr"
GO_VERSION="1.17.6"
AS_VERSION="2021.1.1.21"

echo "✓ Add $USERNAME to sudo users"

usermod -aG wheel $USERNAME

echo "✓ Update & upgrade packages"

dnf check-update
dnf upgrade

echo "✓ Install Fish"

dnf install -y fish
chsh -s /usr/bin/fish

echo "✓ Install Golang $GO_VERSION"

GO_DOWNLOAD_URL="https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"

rm -rf /usr/local/go
wget -O /tmp/go.tar.gz $GO_DOWNLOAD_URL
tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz

echo "✓ Install Android Studio $AS_VERSION with Google-recommended dependencies"

AS_DOWNLOAD_URL="https://dl.google.com/dl/android/studio/ide-zips/$AS_VERSION/android-studio-$AS_VERSION-linux.tar.gz"

rm -rf /usr/local/android-studio
wget -O /tmp/android-studio.tar.gz $AS_DOWNLOAD_URL
tar -C /usr/local -xzf /tmp/android-studio.tar.gz
rm /tmp/android-studio.tar.gz

dnf install -y zlib.i686 ncurses-libs.i686 bzip2-libs.i686

echo "✓ Install VS Code from the official Microsoft repository"

MS_REPO_URL="https://packages.microsoft.com"

rpm --import $MS_REPO_URL/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=$MS_REPO_URL/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=$MS_REPO_URL/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo
dnf check-update
dnf install -y code

echo "✓ Install PRM Fusion (free & non-free)"

RPMF_REPO_URL="https://mirrors.rpmfusion.org/free/fedora/rpmfusion"

dnf install -y $RPMF_REPO_URL-free-release-$(rpm -E %fedora).noarch.rpm $RPMF_REPO_URL-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "✓ Install mpv audio/video player"

dnf install -y mpv

echo "✓ Remove unused packages"

dnf autoremove -y

echo "✓ Manual actions to do"

echo "Add Android Studio icon to GNOME Application list:"
echo "  - Open Android Studio by '/usr/local/android-studio/bin/studio.sh' command"
echo "  - Go to Tools > Create Desktop Entry"
echo ""