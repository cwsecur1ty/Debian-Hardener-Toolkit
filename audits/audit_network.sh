#!/bin/bash

echo "[*] Auditing network settings."

# Check for open ports using netstat
open_ports=$(netstat -tuln | grep -E 'tcp|udp')
echo "[*] Open ports:"
echo "$open_ports"

# Check for unnecessary services (example: telnet)
telnet_service=$(systemctl is-active telnet 2>/dev/null)
echo "[*] Telnet service status:"
echo "$telnet_service"
