#!/bin/bash

echo "[+] Installing and configuring Fail2Ban."

# Install Fail2Ban
if command -v apt > /dev/null; then
    sudo apt update
    sudo apt install -y fail2ban
elif command -v yum > /dev/null; then
    sudo yum install -y epel-release
    sudo yum install -y fail2ban
else
    echo "Unsupported package manager. Please install Fail2Ban manually."
    exit 1
fi

# Create a basic Fail2Ban configuration
cat <<EOF | sudo tee /etc/fail2ban/jail.local
[DEFAULT]
bantime  = 600
findtime  = 600
maxretry = 5

[sshd]
enabled = true
EOF

# Restart Fail2Ban service to apply changes
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban

echo "[+] Fail2Ban installation and configuration completed."
