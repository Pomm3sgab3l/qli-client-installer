#!/bin/bash

# Installationsskript für qli-Client mit Argumenten und Screen-Start

# Überprüfen, ob Argumente übergeben wurden
if [ $# -ne 3 ]; then
    echo "Verwendung: $0 <alias> <cpuThreads> <accessToken>"
    exit 1
fi

ALIAS=$1
CPU_THREADS=$2
ACCESS_TOKEN=$3

# Prüfen, ob wgetosaurs und screen installiert sind
if ! command -v wget &> /dev/null || ! command -v screen &> /dev/null; then
    echo "Fehler: 'wget' oder 'screen' nicht gefunden. Bitte installieren mit:"
    echo "sudo apt update && sudo apt install wget screen"
    exit 1
fi

# Ordner erstellen
mkdir -p q
cd q || { echo "Fehler: Konnte nicht in Ordner q wechseln"; exit 1; }

# Datei herunterladen
wget https://dl.qubic.li/downloads/qli-Client-3.3.3-Linux-x64-beta.tar.gz || { echo "Fehler: Download fehlgeschlagen"; exit 1; }

# Entpacken
tar -xvzf qli-Client-3.3.3-Linux-x64-beta.tar.gz || { echo "Fehler: Entpacken fehlgeschlagen"; exit 1; }

# .tar.gz löschen
rm qli-Client-3.3.3-Linux-x64-beta.tar.gz

# appsettings.json anpassen
cat > appsettings.json << EOL
{
    "ClientSettings": {
        "alias": "${ALIAS}",
        "trainer": {
            "cpuThreads": ${CPU_THREADS}
        },
        "pps": true,
        "accessToken": "${ACCESS_TOKEN}"
    }
}
EOL

# Rechte für qli-Client setzen
if [ -f qli-Client ]; then
    chmod +x qli-Client
else
    echo "Fehler: qli-Client nicht gefunden"
    exit 1
fi

# Screen-Session namens "qubic" starten und qli-Client ausführen
screen -dmS qubic ./qli-Client || { echo "Fehler: Screen-Session konnte nicht gestartet werden"; exit 1; }

echo "Installation, Konfiguration und Start in Screen-Session 'qubic' abgeschlossen!"
echo "Verwende 'screen -r qubic' um die Session zu öffnen."