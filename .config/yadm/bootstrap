#!/bin/sh

system_type=$(uname -s)

configure_mac_settings() {
	echo "Configuring mac settings..."
	# Set the dock
	defaults write com.apple.dock orientation left
	defaults write com.apple.dock tilesize -int 50
	defaults write com.apple.dock "show-recents" -bool false

	# show hidden files
	defaults write com.apple.finder AppleShowAllFiles -string YES

	# Play feedback when volume is changed
	defaults write -globalDomain "com.apple.sound.beep.feedback" -int 1

	# Show bluetooth and sound in Menu Bar
	defaults write "com.apple.controlcenter" "NSStatusItem Visible Bluetooth" -bool true
	defaults write "com.apple.controlcenter" "NSStatusItem Visible Sound" -bool true

	# Disable Siri
	defaults write com.apple.Siri SiriPrefStashedStatusMenuVisible -bool false
	defaults write com.apple.Siri VoiceTriggerUserEnabled -bool false

	# Tap to click
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

	# Show all filename extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	# Do not show wraning before changing an extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

	# Do not show wraning before removing from iCloud Drive
	defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

	# Default view as a list
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

	# setup american keyboard layout with german umlaut
	curl -sL https://api.github.com/repos/patrick-zippenfenig/us-with-german-umlauts/tarball/master | sudo tar xz --exclude=README.md --strip=1 -C /Library/Keyboard\ Layouts/
	echo "Done, remember to change System Preferences -> Keyboard -> Input Sources -> Add Keyboard Layout - U.S. with German Umlauts"
}

configure_iterm() {
	echo "Configuring iTerm2 settings..."
	# Specify the preferences directory
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2/settings/"

	# Tell iTerm2 to use the custom preferences in the directory
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
	echo "Done"
}

if [ "$system_type" = "Darwin" ]; then
	echo "Setting up macOS..."

	# install homebrew if it's missing
	echo "Checking if homebrew is installed..."
	if ! command -v brew >/dev/null 2>&1; then
		echo "Installing homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi

	if [ -f "$HOME/.Brewfile" ]; then
		echo "Updating homebrew bundle"
		brew bundle --global
	fi

	configure_mac_settings
	configure_iterm
fi
