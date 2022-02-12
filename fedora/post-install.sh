#!/bin/bash

#############
# VARIABLES #
#############

USER_NAME="koddr"
RPM_FUSION_REPO_URL="https://mirrors.rpmfusion.org/free/fedora/rpmfusion"
FISH_CONFIG_PATH="/home/$USER_NAME/.config/fish/config.fish"

##############
# RUN SCRIPT #
##############

echo -e "\n✓ Add $USER_NAME to sudo users"

usermod -aG wheel $USER_NAME

echo -e "\n✓ Update & upgrade packages"

dnf check-update
dnf upgrade

echo -e "\n✓ Install PRM Fusion (free & non-free)"

dnf install -y \
    $RPM_FUSION_REPO_URL-free-release-$(rpm -E %fedora).noarch.rpm \
    $RPM_FUSION_REPO_URL-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo -e "\n✓ Install Fish"

dnf install -y fish
chsh -s /usr/bin/fish

echo -e "\n✓ Install user & system utilities"

dnf install -y micro mpv xclip

echo -e "\n✓ Set environment variables"

cat > $FISH_CONFIG_PATH << EOF
# Aliases
set -gx ll "ls -la"

# Editors
set -gx EDITOR micro
set -gx VISUAL code

# Golang
set -gx PATH /usr/local/go/bin $PATH
set -gx GOPATH /home/$USER_NAME/.go
EOF

chown $USER_NAME:$USER_NAME $FISH_CONFIG_PATH

echo -e "\n✓ Enable podman.socket for support Docker features"

systemctl --user enable --now podman.socket

echo -e "\n✓ Remove unused packages"

dnf autoremove -y