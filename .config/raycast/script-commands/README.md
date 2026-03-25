# SonicWall VPN – Script Raycast

Connessione automatica a SonicWall Mobile Connect: apre l’app, inserisce la password dal Keychain, aspetta l’OTP dalla mail, lo inserisce e clicca Connetti.

## Setup

### 1. Keychain (password VPN)

Salva la password VPN nel Keychain (una sola volta):

```bash
security add-generic-password -s "SonicWall VPN" -a "vpn" -w "LA_TUA_PASSWORD"
```

Per cambiare la password in seguito:

```bash
security delete-generic-password -s "SonicWall VPN" -a "vpn"
security add-generic-password -s "SonicWall VPN" -a "vpn" -w "NUOVA_PASSWORD"
```

### 2. Raycast – Aggiungere la cartella script

1. Apri **Raycast** → **Impostazioni** (⌘,)
2. Vai in **Script Commands** (o **Estensioni** → **Script Commands**)
3. Clicca **Add Script Directory** e scegli:
   ```
   ~/.config/raycast/script-commands
   ```
4. Assicurati che **Accessibilità** sia concessa a Raycast (e/o a Terminal/Script Editor se lanci lo script da lì):  
   **Preferenze di sistema** → **Privacy e sicurezza** → **Accessibilità** → aggiungi Raycast.

### 3. Pulsante Connect (click per coordinate)

L’app SonicWall non espone il pulsante Connect all’accessibilità, quindi lo script può usare un **click alle coordinate** che salvi tu una volta.

1. Installa **cliclick**:  
   `brew install cliclick`
2. Apri **SonicWall Mobile Connect** sulla schermata principale.
3. Esegui lo script di cattura:
   ```bash
   ~/.config/raycast/script-commands/sonicwall-capture-connect.sh
   ```
4. Sposta il mouse **sul pulsante Connect**, premi **INVIO** (senza cliccare). La posizione viene salvata in `sonicwall-connect-position.txt`.
5. Da quel momento lo script di connessione userà quel punto per cliccare su Connect.

Se sposti la finestra o cambi risoluzione, ripeti i passi 3–4 per aggiornare la posizione.

### 4. Uso

- In Raycast digita **SonicWall** (o il titolo che vedi per lo script, es. "SonicWall VPN Connect").
- Esegui il comando: l’app si apre, viene cliccato Connect (per coordinate), inserita la password, attesa la mail OTP, inserito l’OTP e cliccato Connetti.

## Personalizzazione

Se serve, puoi modificare in cima a `sonicwall-connect.applescript`:

- **kKeychainAccount** – account usato per il Keychain (se usi un altro `-a` nel `security add-generic-password`).
- **kMailSenderSubstring** – parte dell’indirizzo del mittente della mail OTP (es. `"sonicwall"` o `"noreply@sonicwall.com"`). La mail deve arrivare in **Mail.app** (inbox).
- **kOTPMaxWaitSeconds** – massimo secondi di attesa per l’OTP (default 120).

L’OTP viene cercato come **sequenza di 6 cifre** nel corpo della mail. Se il tuo OTP ha un altro formato (es. 8 cifre), si può adattare la regex nello script (`[0-9]{6}` → es. `[0-9]{8}`).

## Dove sono gli script

- **Raycast**: `~/.config/raycast/script-commands/`
  - `sonicwall-connect.sh` – comando Raycast (metadata + chiamata a AppleScript)
  - `sonicwall-connect.applescript` – logica (app, Keychain, Mail, OTP, Connetti)
  - `sonicwall-capture-connect.sh` – cattura la posizione del pulsante Connect (una tantum)
  - `sonicwall-connect-position.txt` – coordinate salvate (creato dalla cattura)
- La best practice è tenere qui gli script e aggiungere solo questa cartella in Raycast, così restano versionabili e separati dalle estensioni installate da Raycast.

## Test senza Raycast

Da terminale:

```bash
osascript ~/.config/raycast/script-commands/sonicwall-connect.applescript
```
