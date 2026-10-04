# txtex

**Universelle, deterministische Textextraktions- und Normalisierungs-Engine für die Kommandozeile.**

Ein hochpräzises, token-effizientes Werkzeug zur automatisierten Textextraktion aus PDFs, Word-Dokumenten (`.docx`), Präsentationen (`.pptx`), Bilddateien und Screenshots (via Apple Vision OCR auf Apple Silicon), Rich Text (`.rtf`), HTML sowie diversen Plaintext- und Datenformaten. Sämtliche Textinhalte werden vollautomatisch nach der kanonischen typografischen Absatzarchitektur normiert.

---

## Funktionen & Besonderheiten

- **Kanonische Absatz- und Typografie-Normierung:**
  - Überschriften werden unmaskiert ohne `#` formatiert.
  - Tabellen werden deterministisch mit En-Dash-Trennlinien (`–––––––––––––––––––––––––––––––––––`) und tab-getrennten Spalten formatiert.
  - Aufzählungen und nummerierte Listen bleiben strukturiert erhalten.
  - Fließtextabsätze: Der jeweils erste Absatz nach einer Überschrift beginnt linksbündig ohne Einzug; jeder nachfolgende Absatz innerhalb desselben Abschnitts beginnt unmittelbar auf der nächsten Zeile mit genau einem echten Tabulator (`\t`) als Erstzeileneinzug (keine vertikalen Leerzeilen zwischen Absätzen desselben Abschnitts).
  - Abschnitte werden untereinander durch genau zwei vertikale Leerzeilen getrennt.
- **Intelligente PDF-Rekonstruktion:**
  - Automatische Spaltenerkennung (einspaltige und mehrspaltige Layouts).
  - Bereinigung von umbruchbedingten Silbentrennungen (`Ges-` + `chäftspraktiken` -> `Geschäftspraktiken`), während echte Wortkoppelungen (`US-Dollar`, `KI-Infrastruktur`) intakt bleiben.
  - Lückenlose Absatzverschmelzung über Spalten- und Seitengrenzen hinweg.
- **Office- & Bild-Unterstützung:**
  - Word (`.docx`): Nahtlose Verschmelzung von Zierinitialen (Drop Caps) und strukturierte Tabellenüberführung.
  - Bilder (`.png`, `.jpg`, `.jpeg`, `.webp`, `.tiff`): Blitzschnelle Offline-Texterkennung über native Apple Vision OCR auf Apple Silicon (< 40 ms).
  - Folien (`.pptx`), Rich Text (`.rtf`), HTML und Plaintext.
- **Standardisiertes CLI-Hilfeformat (`txt2pdf`-Norm):**
  - Einzeiliges, übersichtliches Hilfemenü via `txtex -h`.
- **Farbcodierte Terminal-Ausgabe (`optimi`-Farbnorm):**
  - Strukturierte Statusbanner, dynamische Trennlinien und präzise Telemetrie (Zeichen-, Wort- und Zeilenanzahl).

---

## Installation

### Einzeiler via Terminal

```bash
curl -fsSL https://raw.githubusercontent.com/jonathank55/txtex/main/install.sh | bash
```

### Manuelle Installation

1. **Repository klonen:**
   ```bash
   git clone https://github.com/jonathank55/txtex.git
   cd txtex
   ```

2. **Installationsskript ausführen:**
   ```bash
   chmod +x install.sh txtex
   ./install.sh
   ```

---

## Verwendung

```bash
txtex [DATEI...] [OPTIONEN]
```

### Optionen

| Option | Parameter | Funktion |
| :--- | :--- | :--- |
| `-h` | – | **Hilfe:** Zeigt die einzeilige Befehlshilfe an. |
| `-o` | `AUSGABE` | **Zieldateipfad:** Schreibt den bereinigten Text in den angegebenen Zieldateipfad (.txt). |
| `-d` | – | **Downloads:** Schreibt das Dokument standardmäßig in den Downloads-Ordner (`~/Downloads/<Dateiname>.txt`). |
| `-s` | – | **Stdout:** Schreibt den extrahierten Text direkt in die Standardausgabe (stdout) ohne Dateispeicherung. |
| `-r` | – | **Raw:** Extrahiert den Rohtext ohne nachträgliche typografische Normalisierung. |
| `-j` | – | **JSON:** Gibt quantitative Metadaten (Pfad, Zeichen, Wörter, Zeilen) als strukturiertes JSON aus. |

---

## Beispiele

```bash
# Extrahiert Text aus PDF und legt ihn standardmäßig als .txt im Downloads-Ordner ab
txtex "dokument.pdf"

# Schreibt das Ergebnis in eine spezifische Zieldatei
txtex "bericht.docx" -o "ausgabe.txt"

# Schnelle Ausgabe direkt auf stdout zur Weiterverarbeitung in Pipelines
txtex "screenshot.png" -s | grep "Suchbegriff"

# Rohtext ohne typografische Absatzarchitektur extrahieren
txtex "folien.pptx" -r -s

# JSON-Telemetrie abrufen
txtex "datenblatt.pdf" -j
```

---

## Lizenz

MIT License — Copyright (c) 2026 Jonathan Klatchko.
