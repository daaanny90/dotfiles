#!/bin/bash
# Cattura la posizione del mouse e la salva per lo script SonicWall.
# Uso: apri SonicWall, sposta il mouse sul pulsante Connect, esegui questo script.

if ! command -v cliclick >/dev/null 2>&1; then
	echo "Installa prima cliclick: brew install cliclick"
	exit 1
fi

DIR="$HOME/.config/raycast/script-commands"
mkdir -p "$DIR"
echo ""
echo "Sposta il mouse sul pulsante Connect di SonicWall..."
echo "Premi INVIO quando sei pronto (non cliccare col mouse)."
read -r

POS=$(cliclick p:.)
# cliclick p:. restituisce tipo "523,412" o "523 412"
X=$(echo "$POS" | cut -d',' -f1 | tr -d ' ')
Y=$(echo "$POS" | cut -d',' -f2 | tr -d ' ')
if [ -z "$Y" ]; then
	Y=$(echo "$POS" | cut -d' ' -f2 | tr -d ' ')
fi

if [ -n "$X" ] && [ -n "$Y" ]; then
	echo "${X},${Y}" > "$DIR/sonicwall-connect-position.txt"
	echo "Posizione salvata: $X,$Y in $DIR/sonicwall-connect-position.txt"
else
	echo "Impossibile leggere la posizione. Riprova."
	exit 1
fi
