#!/bin/bash

echo "[*] Testing harden_permissions.sh."

# Create a temporary world-writable file
# This file will be used to test if the harden script correctly removes world-writable permissions
test_file="/tmp/test_world_writable_file"
touch $test_file
chmod 666 $test_file

# This script should remove the world-writable permissions
bash configs/harden_permissions.sh

# Check if the world-writable permissions were removed
# Checks the file's permissions, and compare them to 644 (rw-r--r--)
if [ $(stat -c "%a" $test_file) -eq 644 ]; then
    echo "[PASS] harden_permissions.sh removed world-writable permissions."
else
    echo "[FAIL] harden_permissions.sh did not remove world-writable permissions."
fi

# Clean up 
rm $test_file
