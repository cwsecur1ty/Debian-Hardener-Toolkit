#!/bin/bash

echo -e "\n[*] Auditing user accounts."

# Check for users with no password set
no_password_users=$(awk -F: '($2 == "") {print $1}' /etc/shadow)
echo -e "\n[*] Users with no password set:"
echo "$no_password_users"
