#!/bin/bash

echo -e "\n[*] Auditing network settings."

# Check for open ports using netstat
open_ports=$(netstat -tuln | grep -E 'tcp|udp')
echo -e "\n[*] Open ports:"
echo "$open_ports"

# Check for unnecessary services (example: telnet)
telnet_service=$(systemctl is-active telnet 2>/dev/null)
echo -e "\n[*] Telnet service status:"
echo -e "\n$telnet_service"
