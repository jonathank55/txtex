#!/usr/bin/env bash
# ==============================================================================
# txtex — Universelle, deterministische Textextraktions-Engine
# Installationsskript für macOS und Linux
# ==============================================================================

set -e

echo "=== Installation von txtex ==="

# 1. Zielverzeichnis im PATH ermitteln
INSTALL_DIR=""
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    INSTALL_DIR="$HOME/.local/bin"
elif [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
else
    mkdir -p "$HOME/.local/bin"
    INSTALL_DIR="$HOME/.local/bin"
    echo "Hinweis: Bitte stellen Sie sicher, dass $HOME/.local/bin in Ihrem PATH liegt."
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 2. Python-Abhängigkeiten prüfen / installieren
echo "Prüfe empfohlene Python-Bibliotheken..."
if command -v pip3 >/dev/null 2>&1; then
    pip3 install pymupdf python-docx python-pptx --break-system-packages >/dev/null 2>&1 || \
    pip3 install pymupdf python-docx python-pptx >/dev/null 2>&1 || true
fi

# 3. Binaries verlinken oder kopieren
echo "Installiere txtex nach $INSTALL_DIR..."
cp "$SCRIPT_DIR/txtex" "$INSTALL_DIR/txtex"
chmod +x "$INSTALL_DIR/txtex"

echo "=============================================================================="
echo "ERFOLG: txtex wurde erfolgreich installiert!"
echo "Befehl: txtex [DATEI] [OPTIONEN]"
echo "Hilfe:  txtex -h"
echo "=============================================================================="
