#!/bin/bash

echo "[*] Testing audit_permissions.sh."

# Create a temporary world-writable file
# This file will be used to test if the audit script correctly identifies world-writable files!
test_file="/tmp/test_world_writable_file"
touch $test_file
chmod 666 $test_file

# Run the audit_permissions.sh script and capture output
output=$(bash audits/audit_permissions.sh)

# Check if the test file is listed in the output
# The grep command searches for the test file in the output
if echo "$output" | grep -q "$test_file"; then
    echo "[PASS] audit_permissions.sh identified the world-writable file."
else
    echo "[FAIL] audit_permissions.sh did not identify the world-writable file."
fi

# Clean up
rm $test_file
