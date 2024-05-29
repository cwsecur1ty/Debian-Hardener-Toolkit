#!/bin/bash

echo "[+] Installing and configuring Fail2Ban."

# Function to check network connectivity
check_network() {
    if ! ping -c 1 google.com &> /dev/null; then
        echo "Network connectivity check failed. Please check your internet connection."
        exit 1
    fi
}

# Check network connectivity before proceeding
check_network

# Install Fail2Ban
if command -v apt > /dev/null; then
    sudo apt update
    sudo apt install -y fail2ban
    if [ $? -ne 0 ]; then
        echo "Failed to install Fail2Ban using apt. Please check your package manager and network settings."
        exit 1
    fi
elif command -v yum > /dev/null; then
    sudo yum install -y epel-release
    sudo yum install -y fail2ban
    if [ $? -ne 0 ]; then
        echo "Failed to install Fail2Ban using yum. Please check your package manager and network settings."
        exit 1
    fi
else
    echo "Unsupported package manager. Please install Fail2Ban manually."
    exit 1
fi

# Create a basic Fail2Ban configuration
cat <<EOF | sudo tee /etc/fail2ban/jail.local > /dev/null
[DEFAULT]
bantime  = 600
findtime  = 600
maxretry = 5

[sshd]
enabled = true
EOF

if [ $? -ne 0 ]; then
    echo "Failed to create /etc/fail2ban/jail.local. Please check your permissions."
    exit 1
fi

# Restart Fail2Ban service to apply changes
sudo systemctl restart fail2ban
if [ $? -ne 0 ]; then
    echo "Failed to restart Fail2Ban service. Please check if Fail2Ban is installed correctly."
    exit 1
fi

sudo systemctl enable fail2ban
if [ $? -ne 0 ]; then
    echo "Failed to enable Fail2Ban service. Please check if Fail2Ban is installed correctly."
    exit 1
fi

echo "[+] Fail2Ban installation and configuration completed."
