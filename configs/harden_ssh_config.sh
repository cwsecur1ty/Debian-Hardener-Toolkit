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

# Restart SSH service
systemctl restart ssh.service
echo "[+] SSH configuration hardened and SSH service restarted."
