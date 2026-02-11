#!/usr/bin/env bash
# tailscale-auto-login.sh

# Run tailscale and capture output line by line
sudo tailscale up --accept-routes 2>&1 | while IFS= read -r line; do
    echo "$line"  # still print to stdout so you see it

    # Check if line contains a login URL
    if [[ "$line" =~ https://login.tailscale.com[^\ ]* ]]; then
        url="${BASH_REMATCH[0]}"
        echo "Opening browser to: $url"
        # Use xdg-open (Linux), open (macOS), or start (Windows WSL)
        if command -v xdg-open &> /dev/null; then
            xdg-open "$url" >/dev/null 2>&1
        elif command -v open &> /dev/null; then
            open "$url"
        elif command -v start &> /dev/null; then
            start "$url"
        else
            echo "Could not detect browser opener, please open manually: $url"
        fi
    fi
done
