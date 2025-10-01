#!/bin/bash

# Copy sample VSCode configuration files
for file in /root/psibase/.vscode/*.sample; do
    cp "$file" "${file%.sample}"
done

# Install dependencies and configure VSCode SDKs
cd packages
yarn
yarn dlx @yarnpkg/sdks vscode

# Symlink .clangd file to workspace root
ln -s /root/psibase/.vscode/.clangd /root/psibase/.clangd