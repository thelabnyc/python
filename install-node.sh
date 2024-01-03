#!/usr/bin/env bash

set -e

mkdir -p /etc/apt/keyrings

# Add apt source for NodeJS
NODE_KEYRING="/etc/apt/keyrings/nodesource.gpg"
curl -fsSL "https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key" \
    | gpg --dearmor -o "${NODE_KEYRING}"
echo "deb [signed-by=${NODE_KEYRING}] https://deb.nodesource.com/node_${NODE_VERSION}.x nodistro main" \
    > /etc/apt/sources.list.d/nodesource.list

# Install packages
apt-get update
apt-get install -y \
    build-essential \
    nodejs \
    npm

# Cleanup
rm -rf /var/lib/apt/lists/*
