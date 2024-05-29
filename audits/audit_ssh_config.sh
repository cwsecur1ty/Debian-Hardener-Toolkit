#!/bin/bash

echo -e "[!] Auditing SSH configuration."

# Check if /etc/ssh/sshd_config exists
if [ ! -f /etc/ssh/sshd_config ]; then
    echo -e "[-] SSH configuration file (/etc/ssh/sshd_config) not found!"
    exit 1
fi

# Function to check a configuration setting
check_config() {
    local setting=$1
    local value=$2
    local recommended=$3

    actual_value=$(grep -E "^${setting} " /etc/ssh/sshd_config | awk '{print $2}')
    if [ "$actual_value" != "$value" ]; then
        echo -e "[!] Warning: $setting is set to $actual_value, recommended is $value"
    else
        echo -e "[+] $setting is correctly set to $value"
    fi
}

# Recommended settings
check_config "PermitRootLogin" "no"
check_config "PasswordAuthentication" "no"
check_config "ChallengeResponseAuthentication" "no"
check_config "X11Forwarding" "no"
check_config "MaxAuthTries" "4"
check_config "PubkeyAuthentication" "yes"
check_config "AuthorizedKeysFile" ".ssh/authorized_keys"

# Check for other potential issues
echo -e "[*] Checking for other potential issues..."
if grep -q "^PermitEmptyPasswords yes" /etc/ssh/sshd_config; then
    echo -e "[!] Warning: PermitEmptyPasswords is enabled, which is insecure."
fi

if grep -q "^UseDNS yes" /etc/ssh/sshd_config; then
    echo -e "[!] Warning: UseDNS is enabled, which may cause slow logins."
fi

echo -e "[*] SSH configuration audit completed."
