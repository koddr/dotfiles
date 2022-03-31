#!/bin/bash

#############
# VARIABLES #
#############

GO_VERSION="1.18"
GO_DOWNLOAD_URL="https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"

##############
# RUN SCRIPT #
##############

echo -e "\n✓ Install/Update Go to $GO_VERSION"

rm -rf /usr/local/go
wget -O /tmp/go.tar.gz $GO_DOWNLOAD_URL
tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz
