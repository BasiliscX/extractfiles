#!/bin/bash

set -e

SCRIPT_NAME="extractfiles"
USER_PATH="$HOME/.local/bin/$SCRIPT_NAME"
SYSTEM_PATH="/usr/local/bin/$SCRIPT_NAME"

echo "🧹 Desinstalador de $SCRIPT_NAME"

if [ -f "$USER_PATH" ]; then
  echo "✅ Instalación encontrada en: $USER_PATH"
  read -rp "¿Querés eliminar esta versión? [s/N]: " CONF
  if [[ "$CONF" =~ ^[Ss]$ ]]; then
    rm "$USER_PATH"
    echo "🗑️  Eliminado correctamente de ~/.local/bin"
  else
    echo "❌ Cancelado."
  fi
elif [ -f "$SYSTEM_PATH" ]; then
  echo "✅ Instalación global encontrada en: $SYSTEM_PATH"
  read -rp "¿Querés eliminar esta versión? (requiere sudo) [s/N]: " CONF
  if [[ "$CONF" =~ ^[Ss]$ ]]; then
    sudo rm "$SYSTEM_PATH"
    echo "🗑️  Eliminado correctamente de /usr/local/bin"
  else
    echo "❌ Cancelado."
  fi
else
  echo "⚠️  No se encontró ninguna instalación de '$SCRIPT_NAME' en el sistema."
fi