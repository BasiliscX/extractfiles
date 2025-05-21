#!/bin/bash

LOGS=0
PATRON=""
OUTPUT="rutas_y_contenido.txt"

log() {
  if [ "$LOGS" -eq 1 ]; then
    local tipo="$1"
    local mensaje="$2"
    case "$tipo" in
      info)    COLOR="\033[0;37m" ;;  # gris
      action)  COLOR="\033[1;34m" ;;  # azul
      success) COLOR="\033[1;32m" ;;  # verde
      warn)    COLOR="\033[1;33m" ;;  # amarillo
      error)   COLOR="\033[1;31m" ;;  # rojo
      *)       COLOR="\033[0m"    ;;  # sin color
    esac
    echo -e "${COLOR}[LOG] $mensaje\033[0m"
  fi
}

# ========================
# Ayuda
# ========================
if [ "$1" == "--help" ]; then
  cat <<EOF
Uso:
  extractfiles <ruta> [cadena_de_búsqueda] [--output nombre.txt] [--logs]

Descripción:
  Recorre recursivamente los archivos dentro de la ruta dada e imprime sus rutas y contenido
  en un archivo de texto plano. Por defecto se incluye todo archivo de texto. Si se especifica
  una cadena de búsqueda, solo se copiarán los archivos que contengan al menos una coincidencia
  exacta. La búsqueda es sensible a espacios, mayúsculas y minúsculas.

Parámetros:

  <ruta>                    Ruta absoluta o con barras invertidas (\\). Si usás barras invertidas,
                            debés encerrar la ruta entre comillas dobles.
                            Ejemplo: extractfiles "/mnt/proyecto\\src\\modulo"

  [cadena_de_búsqueda]      (Opcional) Cadena exacta a buscar dentro de los archivos. Si se
                            encuentra, el archivo será copiado al resultado. Se pueden especificar
                            múltiples cadenas usando el separador ' | ' (espacio-pipe-espacio).
                            Ejemplo: "Error crítico | UpdatePersonalDTO"

  --output nombre.txt       (Opcional) Nombre del archivo de salida. Si no se especifica,
                            se usará 'rutas_y_contenido.txt'. Si no incluye '.txt', se agrega.
                            No se permiten rutas (no puede contener '/').
                            Ejemplo válido: --output resultado.txt

  --logs                    (Opcional) Muestra información detallada del proceso en consola
                            con colores: rutas procesadas, coincidencias, omisiones, errores.

Ejemplos:

  extractfiles /mnt/proyecto
  extractfiles "/mnt/proyecto\\modulo" "Buscar esto"
  extractfiles /mnt/proyecto "una cosa | otra cosa" --logs
  extractfiles /mnt/proyecto "ClaseDTO" --output exportacion

Notas:

  - Las coincidencias distinguen entre mayúsculas y minúsculas.
  - Se ignoran archivos binarios.
  - Si no hay coincidencias, el archivo de salida no se generará.
  - Los archivos ocultos (que comienzan con .) no se procesan.

¿Ideas? ¿Sugerencias? ¿Querés colaborar?
Repositorio: https://github.com/BasiliscX/extractfiles/tree/main-es

EOF
  exit 0
fi


# ========================
# Validar y tomar argumentos
# ========================
if [ -z "$1" ]; then
  echo "Error: Debes proporcionar una ruta."
  exit 1
fi

RAW_RUTA="$1"
shift

if [[ "$1" != "--"* && -n "$1" ]]; then
  PATRON="$1"
  shift
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --logs)
      LOGS=1
      ;;
    --output)
      shift
      if [[ -z "$1" ]]; then
        echo "Error: Debes proporcionar un nombre de archivo luego de --output"
        exit 1
      fi

      if [[ "$1" == *"/"* ]]; then
        echo "Error: No se permiten rutas en --output, solo nombre de archivo (ej: salida.txt)"
        exit 1
      fi

      OUTPUT="$1"
      [[ "$OUTPUT" != *.txt ]] && OUTPUT="${OUTPUT}.txt"
      ;;
    *)
      echo "[ERROR] Opción desconocida: $1"
      exit 1
      ;;
  esac
  shift
done

# ========================
# Preparar ruta
# ========================
RUTA=$(echo "$RAW_RUTA" | sed 's|\\|/|g')
log info "Ruta original: $RAW_RUTA"
log info "Ruta procesada: $RUTA"

if [ ! -d "$RUTA" ]; then
  echo "[ERROR] La ruta no existe o no es un directorio válido: $RUTA"
  exit 1
fi

> "$OUTPUT"
RESULTADO_ENCONTRADO=0
log info "Archivo de salida: $OUTPUT"
[ -n "$PATRON" ] && log info "Patrón de búsqueda: $PATRON"

# ========================
# Función principal
# ========================
recorrer_directorio() {
  local dir="$1"
  log action "Ingresando al directorio: $dir"
  for archivo in "$dir"/*; do
    if [ -d "$archivo" ]; then
      log action "→ Subdirectorio: $archivo"
      recorrer_directorio "$archivo"
    elif [ -f "$archivo" ]; then
      log action "→ Archivo: $archivo"
      if file "$archivo" | grep -q 'text'; then
        log success "  ✓ Archivo de texto válido"

        if [ -n "$PATRON" ]; then
          IFS='|' read -ra BUSQUEDAS <<< "$PATRON"
          MATCH=0
          for term in "${BUSQUEDAS[@]}"; do
            LIMPIO=$(echo "$term" | sed 's/^ *//;s/ *$//')
            if grep -Fq "$LIMPIO" "$archivo"; then
              log success "  ✔ Coincide con '$LIMPIO'"
              MATCH=1
              break
            fi
          done
          if [ "$MATCH" -eq 0 ]; then
            log error "  ✘ No coincide con ningún patrón"
            continue
          fi
        fi

        echo "$archivo" >> "$OUTPUT"
        echo "-----------------" >> "$OUTPUT"
        cat "$archivo" >> "$OUTPUT"
        echo -e "\n\n" >> "$OUTPUT"
        RESULTADO_ENCONTRADO=1
      else
        log warn "  ⚠ Archivo no textual (binario)"
      fi
    fi
  done
}

# ========================
# Ejecutar
# ========================
recorrer_directorio "$RUTA"

if [ "$RESULTADO_ENCONTRADO" -eq 1 ]; then
  echo "Archivo generado: $OUTPUT"
else
  rm "$OUTPUT"
  echo "No se encontraron archivos que coincidan con los criterios."
fi