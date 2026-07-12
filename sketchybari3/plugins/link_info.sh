#!/bin/sh

IFACE="en0"  # change if needed
IP="$(ipconfig getifaddr "$IFACE" 2>/dev/null)"

# If no IP, fall back
if [ "$IP" = "" ]; then
  IP="no-ip"
fi

# Optional: static icon (you can choose anything or remove this)
ICON=""  # example Nerd Font icon for network

# Update the invoking item (same pattern as SketchyBar battery script)
sketchybar --set "$NAME" icon="$ICON" label="E: $IP (1000 Mbit/s)"
