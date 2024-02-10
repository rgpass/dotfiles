#!/usr/bin/env bash

source "./colors.sh"

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Show Bluetooth in menu bar
defaults -currentHost write com.apple.controlcenter.plist Bluetooth -int 18

###############################################################################
# Finder                                                                      #
###############################################################################

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Set the icon size of Dock items to 64 pixels
defaults write com.apple.dock tilesize -int 64

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Disallow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool false

###############################################################################
# Browser                                                                     #
###############################################################################

# Set default browser to Arc
open -a "Arc" --args --make-default-browser

###############################################################################
# Manual steps                                                                #
###############################################################################

yellow "> Some Mac OSX preferences must be set manually. Follow these steps..."

yellow "> System Preferences > Displays > Refresh rate > 60 Hertz"
yellow "> System Preferences > General > About > Name > appropriate name"
yellow "> System Preferences > Notifications > Messages > Show previews > Never"
yellow "> System Preferences > Notifications > Messages > Play sound for notification > off"

###############################################################################
# Raycast                                                                     #
###############################################################################

yellow "> Steps to set up Raycast:"
yellow "> 1. Open Spotlight (Cmd+Space) and open Raycast"
yellow "> 2. Follow setup wizard"
yellow "> 3. System Preferences > Keyboard > Shortcuts > Spotlight > uncheck both"
yellow "> 4. Raycast (click icon in menu bar) > Settings > Raycast Hotkey > Cmd+Space"
yellow ">"
yellow "> After Raycast setup complete, configure snippets"

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
  "Address Book" \
  "Calendar" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "Mail" \
  "Messages" \
  "Photos" \
  "Safari" \
  "SystemUIServer" \
  "iCal"; do
  killall "${app}" &> /dev/null
done
yellow "> System settings changed. Note that some of these changes require a logout/restart to take effect..."
