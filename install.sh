#!/bin/bash

set -e

SCRIPT_NAME="extractfiles"
SOURCE_FILE="extractfiles.sh"

echo "🔧 Installing $SCRIPT_NAME"

echo ""
echo "Where do you want to install the '$SCRIPT_NAME' command?"
echo "  [1] For this user only  (installs to ~/.local/bin)"
echo "  [2] System-wide (requires sudo, installs to /usr/local/bin)"
read -rp "Choose an option [1/2]: " OPTION

if [[ "$OPTION" == "1" ]]; then
  INSTALL_PATH="$HOME/.local/bin/$SCRIPT_NAME"
  echo "→ Installing to $INSTALL_PATH (user)"
  mkdir -p "$HOME/.local/bin"
  cp "$SOURCE_FILE" "$INSTALL_PATH"
  chmod +x "$INSTALL_PATH"
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "⚠️  Added ~/.local/bin to PATH in your .bashrc. Run 'source ~/.bashrc' or restart your terminal."
  fi
  echo "✅ Installed locally as '$SCRIPT_NAME'"
elif [[ "$OPTION" == "2" ]]; then
  INSTALL_PATH="/usr/local/bin/$SCRIPT_NAME"
  echo "→ Installing to $INSTALL_PATH (system-wide)"
  sudo cp "$SOURCE_FILE" "$INSTALL_PATH"
  sudo chmod +x "$INSTALL_PATH"
  echo "✅ Installed globally as '$SCRIPT_NAME'"
else
  echo "❌ Invalid option. Installation cancelled."
  exit 1
fi

echo ""
echo "📄 Run '$SCRIPT_NAME --help' to get started."
