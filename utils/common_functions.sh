#!/bin/bash

# Function to check if the script is being run as root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "[!] Script must be run as root. Exiting..."
        exit 1
    fi
}
    
# Function to log a message with a timestamp
log_message() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message"
}

# Function to create a backup of a specified file
backup_file() {
    local file_path=$1
    if [ -f "$file_path" ]; then
        local backup_path="${file_path}.bak.$(date '+%Y%m%d%H%M%S')"
        cp "$file_path" "$backup_path"
        log_message "Backup of $file_path created at $backup_path"
    else
        log_message "File $file_path does not exist. No backup created."
    fi
}
