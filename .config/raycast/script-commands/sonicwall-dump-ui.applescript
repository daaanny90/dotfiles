-- Diagnostica UI SonicWall: con l'app aperta (schermata principale), esegui questo script.
-- Scrive in ~/.config/raycast/script-commands/sonicwall-ui-dump.txt l'elenco di finestre, pulsanti e campi.

set kAppName to "SonicWall Mobile Connect"
set outputLines to {"=== SonicWall UI Dump " & (current date as text) & " ===", ""}

tell application "System Events"
	tell process kAppName
		set frontmost to true
		delay 0.5
		try
			set winList to every window
			set winCount to count of winList
			set outputLines to outputLines & {"Finestre: " & winCount, ""}
			repeat with wIdx from 1 to winCount
				set win to item wIdx of winList
				try
					set winName to (name of win) as text
				on error
					set winName to "(no name)"
				end try
				set outputLines to outputLines & {"--- Window " & wIdx & ": " & winName & " ---", ""}
				try
					set btnList to every button of win
					set outputLines to outputLines & {"  Pulsanti (window): " & (count of btnList)}
					repeat with b in btnList
						try
							set bn to (name of b) as text
							set bd to ""
							set br to ""
							try
								set bd to (value of attribute "AXDescription" of b) as text
							end try
							try
								set br to (value of attribute "AXRoleDescription" of b) as text
							end try
							set outputLines to outputLines & {"    [button] name=\"" & bn & "\" description=\"" & bd & "\" roleDesc=\"" & br & "\""}
						end try
					end repeat
					set outputLines to outputLines & {""}
				end try
				try
					repeat with grp in (every group of win)
						try
							set grpName to (name of grp) as text
							set outputLines to outputLines & {"  Group: \"" & grpName & "\""}
							set grpBtns to every button of grp
							repeat with b in grpBtns
								try
									set bn to (name of b) as text
									set bd to ""
									try
										set bd to (value of attribute "AXDescription" of b) as text
									end try
									set outputLines to outputLines & {"    [button] name=\"" & bn & "\" description=\"" & bd & "\""}
								end try
							end repeat
							set grpFields to every text field of grp
							repeat with tf in grpFields
								try
									set fn to (name of tf) as text
									set ph to ""
								try
									set ph to (value of attribute "AXPlaceholderValue" of tf) as text
								end try
									set outputLines to outputLines & {"    [text field] name=\"" & fn & "\" placeholder=\"" & ph & "\""}
								end try
							end repeat
						end try
					end repeat
					set outputLines to outputLines & {""}
				end try
				try
					set sheetList to every sheet of win
					if (count of sheetList) > 0 then
						set outputLines to outputLines & {"  Sheet(s): " & (count of sheetList)}
						repeat with sh in sheetList
							try
								set shBtns to every button of sh
								repeat with b in shBtns
									try
										set bn to (name of b) as text
										set outputLines to outputLines & {"    [sheet button] name=\"" & bn & "\""}
									end try
								end repeat
							end try
						end repeat
						set outputLines to outputLines & {""}
					end if
				end try
			end repeat
		end try
	end tell
end tell

set textToWrite to ""
repeat with L in outputLines
	set textToWrite to textToWrite & L & linefeed
end repeat

set posixPath to (POSIX path of (path to home folder)) & ".config/raycast/script-commands/sonicwall-ui-dump.txt"
do shell script "mkdir -p " & quoted form of ((POSIX path of (path to home folder)) & ".config/raycast/script-commands")
set f to open for access (POSIX file posixPath) with write permission
write textToWrite to f
close access f
display dialog "Dump salvato in:" & linefeed & posixPath with title "SonicWall UI Dump" buttons {"OK"} default button "OK"
