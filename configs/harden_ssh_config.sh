#!/bin/bash

echo "[*] Hardening SSH configuration."

# Backup existing sshd_config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Set SSH configuration options
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config
sed -i 's/^#MaxAuthTries.*/MaxAuthTries 4/' /etc/ssh/sshd_config

# Ensure key-based authentication is enabled
grep -q "^PubkeyAuthentication" /etc/ssh/sshd_config
if [ $? -ne 0 ]; then
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
else
    sed -i 's/^#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
fi

grep -q "^AuthorizedKeysFile" /etc/ssh/sshd_config
if [ $? -ne 0 ]; then
    echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config
else
    sed -i 's/^#AuthorizedKeysFile.*/AuthorizedKeysFile .ssh\/authorized_keys/' /etc/ssh/sshd_config
fi

# Restart SSH service
systemctl restart ssh.service
if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to restart SSH service. Please check the SSH configuration."
    exit 1
fi

echo "[+] SSH configuration hardened and SSH service restarted."
