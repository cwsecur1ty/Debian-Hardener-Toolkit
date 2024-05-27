#!/bin/bash

source utils/common_functions.sh
# Check script is running as root
check_root

echo -e "\n[*] Auditing file permissions."

# Check for world-writable files
world_writable_files=$(find / -xdev -type f -perm -0002 2>/dev/null)
echo -e "\n[*] World-writable files:"
echo "$world_writable_files"
