#!/bin/bash

# Define the network range
NETWORK="10.1.1"

# Function to check ping and domain
check_host() {
    local ip=$1
    echo "Checking $ip..."

    # Ping the IP (1 packet, 1-second timeout)
    if ping -c 1 -W 1 "$ip" > /dev/null 2>&1; then
        echo "  Ping: SUCCESS"
    else
        echo "  Ping: FAILED"
    fi

    # Reverse DNS lookup using 'host' command
    DOMAIN=$(host "$ip" 2>/dev/null | grep "domain name pointer" | awk '{print $5}' | sed 's/\.$//')
    if [ -n "$DOMAIN" ]; then
        echo "  Domain: $DOMAIN"
    else
        echo "  Domain: No domain name resolved"
    fi

    echo "-------------------"
}

# Loop through all IPs in the 192.168.1.0/24 range
for i in {0..255}; do
    IP="$NETWORK.$i"
    check_host "$IP"
done

echo "Scan complete!"