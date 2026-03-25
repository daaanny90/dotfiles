-- SonicWall VPN: avvia app, Connect, password da Keychain, OTP da Mail, Connetti
-- Configurazione (modifica se serve)
set kKeychainService to "SonicWall VPN"
set kKeychainAccount to "vpn"
set kMailSenderSubstring to "sonicwall"
set kAppName to "SonicWall Mobile Connect"
set kOTPMaxWaitSeconds to 120
set kOTPPollInterval to 2
set kPositionFilePath to (POSIX path of (path to home folder)) & ".config/raycast/script-commands/sonicwall-connect-position.txt"

-- Recupera password da Keychain
try
	set vpnPassword to do shell script "security find-generic-password -s " & quoted form of kKeychainService & " -a " & quoted form of kKeychainAccount & " -w 2>/dev/null"
on error
	display alert "SonicWall VPN" message "Password non trovata nel Keychain. Aggiungila con:\n\nsecurity add-generic-password -s \"SonicWall VPN\" -a \"vpn\" -w \"TUA_PASSWORD\""
	return
end try

-- Avvia l'app
tell application kAppName to activate
delay 3

tell application "System Events"
	tell process kAppName
		set frontmost to true
		delay 0.8

		-- Opzione 1: click per coordinate se hai salvato la posizione (vedi README)
		set connectClicked to false
		try
			set posContent to do shell script "cat \"$HOME/.config/raycast/script-commands/sonicwall-connect-position.txt\" 2>/dev/null | tr -d '\\n\\r' || true"
			if posContent is not "" then
				set AppleScript's text item delimiters to {",", " ", tab}
				set posParts to text items of posContent
				set AppleScript's text item delimiters to ""
				if (count of posParts) >= 2 then
					set posX to (item 1 of posParts as text)
					set posY to (item 2 of posParts as text)
					try
						-- PATH da AppleScript non include Homebrew; usa path completo o PATH esplicito
						do shell script "export PATH=\"/opt/homebrew/bin:/usr/local/bin:$PATH\"; cliclick c:" & posX & "," & posY
						set connectClicked to true
					on error errMsg
						display alert "SonicWall VPN" message "cliclick non eseguito: " & errMsg
						return
					end try
				end if
			end if
		end try

		-- Opzione 2: cerca pulsante Connect per nome/descrizione
		if not connectClicked then
		try
			set win to window 1
			set allButtons to {}
			try
				set allButtons to (every button of win)
			end try
			repeat with grp in (every group of win)
				try
					set allButtons to allButtons & (every button of grp)
				end try
			end repeat
			repeat with b in allButtons
				try
					set btnName to (name of b) as text
					set btnDesc to ""
					try
						set btnDesc to (value of attribute "AXDescription" of b) as text
					end try
					if btnName contains "Connect" or btnName contains "Connetti" or btnName is "Connect" or btnName is "Connetti" then
						click b
						set connectClicked to true
						exit repeat
					end if
					if btnDesc contains "Connect" or btnDesc contains "Connetti" then
						click b
						set connectClicked to true
						exit repeat
					end if
				end try
			end repeat
			if not connectClicked then
				click button "Connect" of win
				set connectClicked to true
			end if
		on error
			if not connectClicked then
				try
					click button "Connetti" of window 1
					set connectClicked to true
				end try
			end if
		end try
		end if

		if not connectClicked then
			set posFileExists to false
			try
				set checkResult to do shell script "test -f \"$HOME/.config/raycast/script-commands/sonicwall-connect-position.txt\" && echo 1 || echo 0"
				set posFileExists to (checkResult contains "1")
			end try
			if posFileExists then
				display alert "SonicWall VPN" message "File posizione presente ma click fallito. Controlla che cliclick sia installato: brew install cliclick"
			else
				display alert "SonicWall VPN" message "Pulsante Connect non trovato.\n\nPer usare il click per coordinate:\n1. brew install cliclick\n2. Apri SonicWall, esegui:\n   ~/.config/raycast/script-commands/sonicwall-capture-connect.sh\n   Sposta il mouse su Connect e premi INVIO."
			end if
			return
		end if

		delay 2

		-- Cerca il campo password (in finestra o in sheet) e cliccalo prima di digitare
		set pwFieldFound to false
		try
			set win to window 1
			set textFields to (every text field of win)
			try
				set textFields to textFields & (every text field of sheet 1 of win)
			end try
			repeat with grp in (every group of win)
				try
					set textFields to textFields & (every text field of grp)
				end try
			end repeat
			if (count of textFields) > 0 then
				-- Preferisci campo con "password" nel nome/placeholder, altrimenti ultimo (di solito è la password)
				set targetField to missing value
				repeat with tf in textFields
					try
						set ph to (value of attribute "AXPlaceholderValue" of tf) as text
						if ph contains "password" or ph contains "Password" then
							set targetField to tf
							exit repeat
						end if
					end try
				end repeat
				if targetField is missing value then
					set targetField to item (count of textFields) of textFields
				end if
				click targetField
				delay 0.3
				keystroke vpnPassword
				set pwFieldFound to true
			end if
		end try

		if not pwFieldFound then
			-- Campo non trovato dall'accessibilità: il focus è già sul campo password, digita direttamente
			keystroke vpnPassword
		end if

		delay 0.5

		-- Conferma (OK / Sign in / Accedi)
		set submitClicked to false
		try
			set win to window 1
			set allButtons to {}
			try
				set allButtons to (every button of win)
			end try
			try
				set allButtons to allButtons & (every button of sheet 1 of win)
			end try
			repeat with grp in (every group of win)
				try
					set allButtons to allButtons & (every button of grp)
				end try
			end repeat
			repeat with b in allButtons
				try
					set btnName to (name of b) as text
					if btnName is "OK" or btnName is "Sign In" or btnName is "Accedi" or btnName is "Login" or btnName contains "Sign" or btnName contains "Accedi" then
						click b
						set submitClicked to true
						exit repeat
					end if
				end try
			end repeat
		end try
		if not submitClicked then
			try
				key code 36
			end try
		end if
	end tell
end tell

delay 1
