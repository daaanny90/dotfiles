#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SonicWall VPN Connect
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon 🔐
# @raycast.packageName VPN
#
# Documentation:
# @raycast.description Apre SonicWall, inserisce password da Keychain, legge OTP da Mail e completa la connessione.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
osascript "$SCRIPT_DIR/sonicwall-connect.applescript"
