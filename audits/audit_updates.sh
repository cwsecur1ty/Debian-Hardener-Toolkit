#!/bin/bash

echo -e "\n[*] Auditing system updates and security patches."

# Update the package index
apt update -qq

# List available updates
echo -e "\n[*] Available updates:"
apt list --upgradable

# List installed security patches
echo -e "\n[+] Installed security patches:"
apt list --installed | grep 'security'
