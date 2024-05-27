#!/bin/bash

echo -e "[*] Hardening SSH configuration."

# Check if /etc/ssh/sshd_config exists
if [ ! -f /etc/ssh/sshd_config ]; then
    echo -e "[-] SSH configuration file (/etc/ssh/sshd_config) not found!"
    exit 1
fi

# Function to set a configuration setting
set_config() {
    local setting=$1
    local value=$2

    if grep -q "^${setting} " /etc/ssh/sshd_config; then
        sed -i "s/^${setting} .*/${setting} ${value}/" /etc/ssh/sshd_config
    else
        echo -e "[*] ${setting} ${value}" >> /etc/ssh/sshd_config
    fi
    echo -e "[+] Set $setting to $value"
}

# Apply recommended settings
set_config "PermitRootLogin" "no"
set_config "PasswordAuthentication" "no"
set_config "ChallengeResponseAuthentication" "no"
set_config "X11Forwarding" "no"
set_config "MaxAuthTries" "4"

# Remove insecure settings
sed -i '/^PermitEmptyPasswords yes/d' /etc/ssh/sshd_config
sed -i '/^UseDNS yes/d' /etc/ssh/sshd_config

# Restart SSH service to apply changes
systemctl restart sshd
echo "[+] SSH configuration hardened and SSH service restarted."
