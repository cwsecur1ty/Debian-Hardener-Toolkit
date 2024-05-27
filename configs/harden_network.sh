#!/bin/bash

echo -e "\n[!] Hardening network settings."

# Disable unnecessary services to reduce the attack surface.
# Example: Disabling the telnet service, which is insecure.
echo -e "\n[+] Disabling unnecessary services."
if systemctl is-active --quiet telnet; then
    systemctl disable telnet
    systemctl stop telnet
    echo -e "\n[+] Telnet service disabled."
fi

# Configure the firewall to restrict network traffic.
# Example: Using UFW (Uncomplicated Firewall) to deny all incoming connections except SSH.
# Sets firewall to Implicit Deny
echo -e "\n[!] Configuring firewall."
ufw default deny incoming # Implicit Deny # Deny all incoming connections by default.
ufw default allow outgoing  # Allow all outgoing connections by default.
ufw allow ssh  # Explicit allow any incoming SSH connections.
ufw enable  # Enable the firewall with the above rules.
echo -e "\n[+] Firewall configured to deny all incoming, except SSH."
