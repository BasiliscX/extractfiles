#!/bin/bash

LOGS=0
PATTERN=""
OUTPUT="extracted_output.txt"

log() {
  if [ "$LOGS" -eq 1 ]; then
    local type="$1"
    local message="$2"
    case "$type" in
      info)    COLOR="\033[0;37m" ;;  # gray
      action)  COLOR="\033[1;34m" ;;  # blue
      success) COLOR="\033[1;32m" ;;  # green
      warn)    COLOR="\033[1;33m" ;;  # yellow
      error)   COLOR="\033[1;31m" ;;  # red
      *)       COLOR="\033[0m"    ;;  # reset
    esac
    echo -e "${COLOR}[LOG] $message\033[0m"
  fi
}

# ========================
# Help menu
# ========================
if [ "$1" == "--help" ]; then
  cat <<EOF
Usage:
  extractfiles <path> [search_string] [--output name.txt] [--logs]

Description:
  Recursively scans all files within the given path and writes their paths and contents
  to a plain text output file. By default, all text files are included. If a search string
  is specified, only files that contain at least one exact match will be included.
  Matching is sensitive to spaces, uppercase and lowercase characters.

Parameters:

  <path>                  Absolute path or one with backslashes (\\). If using backslashes,
                          enclose the path in double quotes.
                          Example: extractfiles "/mnt/project\\src\\module"

  [search_string]         (Optional) Exact string to look for inside the files. If any match
                          is found, the file is included. You can pass multiple strings
                          separated with ' | ' (space-pipe-space).
                          Example: "Critical error | UpdatePersonalDTO"

  --output name.txt       (Optional) Name of the output file. If not specified,
                          'extracted_output.txt' will be used. If no '.txt' is provided,
                          it will be added. Paths are not allowed (no slashes).
                          Valid: --output result.txt

  --logs                  (Optional) Enables detailed console output with colored logs:
                          processed paths, matches, skips, and errors.

Examples:

  extractfiles /mnt/project
  extractfiles "/mnt/project\\module" "Find this"
  extractfiles /mnt/project "one string | another one" --logs
  extractfiles /mnt/project "ClassDTO" --output export

Notes:

  - Matches are case-sensitive and space-sensitive.
  - Binary files are ignored.
  - If no matches are found, no output file will be created.
  - Hidden files (starting with .) are ignored.

Suggestions? Ideas? Want to contribute?
Repository: https://github.com/BasiliscX/extractfiles

EOF
  exit 0
fi

# ========================
# Argument validation
# ========================
if [ -z "$1" ]; then
  echo "Error: You must provide a path."
  exit 1
fi

RAW_PATH="$1"
shift

if [[ "$1" != "--"* && -n "$1" ]]; then
  PATTERN="$1"
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
        echo "Error: You must provide a file name after --output"
        exit 1
      fi

      if [[ "$1" == *"/"* ]]; then
        echo "Error: --output must be a file name only, not a path (e.g., result.txt)"
        exit 1
      fi

      OUTPUT="$1"
      [[ "$OUTPUT" != *.txt ]] && OUTPUT="${OUTPUT}.txt"
      ;;
    *)
      echo "[ERROR] Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done

# ========================
# Normalize and check path
# ========================
PATH_TO_USE=$(echo "$RAW_PATH" | sed 's|\\|/|g')
log info "Original path: $RAW_PATH"
log info "Processed path: $PATH_TO_USE"

if [ ! -d "$PATH_TO_USE" ]; then
  echo "[ERROR] Path does not exist or is not a valid directory: $PATH_TO_USE"
  exit 1
fi

> "$OUTPUT"
FOUND_MATCHES=0
log info "Output file: $OUTPUT"
[ -n "$PATTERN" ] && log info "Search pattern: $PATTERN"

# ========================
# Main logic
# ========================
scan_directory() {
  local dir="$1"
  log action "Entering directory: $dir"
  for file in "$dir"/*; do
    if [ -d "$file" ]; then
      log action "→ Subdirectory: $file"
      scan_directory "$file"
    elif [ -f "$file" ]; then
      log action "→ File: $file"
      if file "$file" | grep -q 'text'; then
        log success "  ✓ Valid text file"

        if [ -n "$PATTERN" ]; then
          IFS='|' read -ra SEARCH_TERMS <<< "$PATTERN"
          MATCHED=0
          for term in "${SEARCH_TERMS[@]}"; do
            CLEANED=$(echo "$term" | sed 's/^ *//;s/ *$//')
            if grep -Fq "$CLEANED" "$file"; then
              log success "  ✔ Match found: '$CLEANED'"
              MATCHED=1
              break
            fi
          done
          if [ "$MATCHED" -eq 0 ]; then
            log error "  ✘ No pattern matched"
            continue
          fi
        fi

        echo "$file" >> "$OUTPUT"
        echo "-----------------" >> "$OUTPUT"
        cat "$file" >> "$OUTPUT"
        echo -e "\n\n" >> "$OUTPUT"
        FOUND_MATCHES=1
      else
        log warn "  ⚠ Not a text file (skipped)"
      fi
    fi
  done
}

# ========================
# Execute
# ========================
scan_directory "$PATH_TO_USE"

if [ "$FOUND_MATCHES" -eq 1 ]; then
  echo "Output file generated: $OUTPUT"
else
  rm "$OUTPUT"
  echo "No matching files found. No output file created."
fi
