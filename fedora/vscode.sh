#!/bin/bash

#############
# VARIABLES #
#############

MS_REPO_URL="https://packages.microsoft.com"

##############
# RUN SCRIPT #
##############

echo -e "\n✓ Add Microsoft repository"

rpm --import $MS_REPO_URL/keys/microsoft.asc

cat > /etc/yum.repos.d/vscode.repo << EOF
[code]
name=Visual Studio Code
baseurl=$MS_REPO_URL/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=$MS_REPO_URL/keys/microsoft.asc
EOF

echo -e "\n✓ Update Fedora packages"

dnf check-update

echo -e "\n✓ Install VS Code from the official Microsoft repository"

dnf install -y code