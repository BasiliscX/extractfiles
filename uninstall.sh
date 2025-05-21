#!/bin/bash

set -e

SCRIPT_NAME="extractfiles"
USER_PATH="$HOME/.local/bin/$SCRIPT_NAME"
SYSTEM_PATH="/usr/local/bin/$SCRIPT_NAME"

echo "🧹 Uninstaller for $SCRIPT_NAME"

if [ -f "$USER_PATH" ]; then
  echo "✅ Installation found at: $USER_PATH"
  read -rp "Do you want to remove this version? [y/N]: " CONF
  if [[ "$CONF" =~ ^[Yy]$ ]]; then
    rm "$USER_PATH"
    echo "🗑️  Successfully removed from ~/.local/bin"
  else
    echo "❌ Cancelled."
  fi
elif [ -f "$SYSTEM_PATH" ]; then
  echo "✅ Global installation found at: $SYSTEM_PATH"
  read -rp "Do you want to remove this version? (requires sudo) [y/N]: " CONF
  if [[ "$CONF" =~ ^[Yy]$ ]]; then
    sudo rm "$SYSTEM_PATH"
    echo "🗑️  Successfully removed from /usr/local/bin"
  else
    echo "❌ Cancelled."
  fi
else
  echo "⚠️  No installation of '$SCRIPT_NAME' was found on this system."
fi
