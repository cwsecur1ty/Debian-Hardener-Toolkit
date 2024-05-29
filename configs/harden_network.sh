#!/bin/bash

echo -e "\n[!] Hardening network settings."

# Determine the directory where this script is located
SCRIPT_DIR=$(dirname $(realpath $0))

# Load configuration
CONFIG_FILE="$SCRIPT_DIR/harden_network_config.ini"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Function to read configuration values
get_config_value() {
    local section=$1
    local key=$2
    awk -F '=' -v section="$section" -v key="$key" '
        /^\[/{in_section=0} 
        /^\['"$section"'\]/{in_section=1} 
        in_section && $1 ~ key{gsub(/ /, "", $2); print $2; exit}
    ' "$CONFIG_FILE"
}

# Disable unnecessary services
echo -e "\n[+] Disabling unnecessary services."
DISABLE_SERVICES=$(get_config_value "services" "disable_services")
for service in ${DISABLE_SERVICES//,/ }; do
    if systemctl is-active --quiet $service; then
        systemctl disable $service
        systemctl stop $service
        echo -e "\n[+] $service service disabled."
    fi
done

# Configure the firewall to restrict network traffic
echo -e "\n[!] Configuring firewall."
DENY_INCOMING=$(get_config_value "firewall" "deny_incoming")
ALLOW_OUTGOING=$(get_config_value "firewall" "allow_outgoing")
ALLOW_PORTS=$(get_config_value "firewall" "allow_ports")

if [ "$DENY_INCOMING" == "yes" ]; then
    yes | ufw default deny incoming
    echo -e "\n[+] Denying all incoming connections by default."
fi

if [ "$ALLOW_OUTGOING" == "yes" ]; then
    yes | ufw default allow outgoing
    echo -e "\n[+] Allowing all outgoing connections by default."
fi

for port in ${ALLOW_PORTS//,/ }; do
    yes | ufw allow $port
    echo -e "\n[+] Allowing incoming connections on port $port."
done

yes | ufw enable
echo -e "\n[+] Firewall configured according to the specified settings."
