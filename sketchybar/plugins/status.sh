#!/bin/sh

# --- Network ---
IFACE="en0"
IP=$(ipconfig getifaddr "$IFACE" 2>/dev/null)
[ -z "$IP" ] && IP="no-ip"
LINK="- Mbit/s"

# --- Battery ---
PCT=$(pmset -g batt | grep -Eo "[0-9]+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep "AC Power" >/dev/null && echo "↯" || echo " ")

# --- CPU ---
CORES=$(sysctl -n hw.ncpu)

CPU=$(ps -A -o %cpu | awk -v c="$CORES" '
  { s += $1 }
  END { printf "%02d", s / c }
')

# --- Load ---
LOAD=$(sysctl -n vm.loadavg | awk '{printf "%.2f", $2}')

# --- Date ---
TIME=$(date "+%Y-%m-%d %H:%M:%S")

# ------------------------------
#   FIXED-WIDTH COLUMNS
# ------------------------------
# Field widths:
# IP: 15 chars
# Link: 12 chars
# Battery pct: 4 chars
# CPU: 4 chars
# Load: 5 chars

IFACE="en0"

ICON=$(networksetup -getinfo Wi-Fi 2>/dev/null | grep -q "IP address" && echo "W" || echo "E")


LINE=$(printf "$ICON: %-15s (%-12s) | BAT %-4s [%-1s] | CPU: %-4s | %-5s | %s" \
              "$IP" \
              "$LINK" \
              "$PCT%" \
              "$CHARGING" \
              "$CPU%" \
              "$LOAD" \
              "$TIME")

sketchybar --set "$NAME" label="$LINE"

