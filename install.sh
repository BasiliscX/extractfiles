#!/bin/bash

set -e

SCRIPT_NAME="extractfiles"
SOURCE_FILE="extractfiles.sh"

echo "🔧 Instalador de $SCRIPT_NAME"

echo ""
echo "¿Dónde querés instalar el comando '$SCRIPT_NAME'?"
echo "  [1] Solo para este usuario  (instala en ~/.local/bin)"
echo "  [2] Global (requiere sudo, instala en /usr/local/bin)"
read -rp "Elegí una opción [1/2]: " OPCION

if [[ "$OPCION" == "1" ]]; then
  INSTALL_PATH="$HOME/.local/bin/$SCRIPT_NAME"
  echo "→ Instalando en $INSTALL_PATH (usuario)"
  mkdir -p "$HOME/.local/bin"
  cp "$SOURCE_FILE" "$INSTALL_PATH"
  chmod +x "$INSTALL_PATH"
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "⚠️  Agregado ~/.local/bin al PATH en tu .bashrc. Ejecutá 'source ~/.bashrc' o reiniciá terminal."
  fi
  echo "✅ Instalado localmente como '$SCRIPT_NAME'"
elif [[ "$OPCION" == "2" ]]; then
  INSTALL_PATH="/usr/local/bin/$SCRIPT_NAME"
  echo "→ Instalando en $INSTALL_PATH (global)"
  sudo cp "$SOURCE_FILE" "$INSTALL_PATH"
  sudo chmod +x "$INSTALL_PATH"
  echo "✅ Instalado globalmente como '$SCRIPT_NAME'"
else
  echo "❌ Opción inválida. Instalación cancelada."
  exit 1
fi

echo ""
echo "📄 Ejecutá '$SCRIPT_NAME --help' para comenzar."