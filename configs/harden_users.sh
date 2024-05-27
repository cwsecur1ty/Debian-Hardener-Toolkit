#!/bin/bash

echo -e "\n[!] Hardening user accounts."

# Enforce password policies to enhance security.
# Example: Setting a minimum password length of 12 characters.
# Password policies can be modified to desired practice.
echo -e "\n[+] Enforcing password policies..."
if [ -f /etc/login.defs ]; then
    # Modify the PASS_MIN_LEN parameter to set the minimum password length.
    sed -i 's/^PASS_MIN_LEN.*/PASS_MIN_LEN 12/' /etc/login.defs
    echo -e "\n[+] Set minimum password length to 12."
fi

# Identify and lock user accounts with no password set.
# User accounts without passwords are vulnerable.
no_password_users=$(awk -F: '($2 == "") {print $1}' /etc/shadow)
for user in $no_password_users; do
    passwd -l $user
    echo -e "\n[!] Locked user account with no password: $user"
done
