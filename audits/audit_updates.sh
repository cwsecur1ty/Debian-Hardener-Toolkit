#!/bin/bash

echo "[*] Auditing system updates and security patches."

# Update the package index
apt update -qq

# List available updates
echo "[*] Available updates:"
apt list --upgradable

# List installed security patches
echo "[+] Installed security patches:"
apt list --installed | grep 'security'
