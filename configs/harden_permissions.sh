#!/bin/bash

source utils/common_functions.sh
# Check script is run as root
check_root

echo -e "\n[!] Hardening file permissions."

# Find and remove world-writable permissions from files.
# World-writable files can be modified by any user.
find / -xdev -type f -perm -0002 -exec chmod o-w {} \;
echo -e "\n[+] Removed world-writable permissions."

# Set specific permissions for key directories to restrict access.
# Example: Setting /etc permissions to 700 restricts access to only the owner (root).
chmod 700 /etc
echo -e "\n[+] Set /etc permissions to 700."
