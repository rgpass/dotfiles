#!/usr/bin/env bash

###############################################################################
# References                                                                  #
# KCD: https://github.com/kentcdodds/dotfiles/blob/main/.macos                #
# Mathias Bynens: https://github.com/mathiasbynens/dotfiles/blob/main/.macos  #
# Tim Kersey: https://github.com/tkersey/dotfiles/blob/main/install           #
###############################################################################

###############################################################################
# Initial setup                                                               #
###############################################################################

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Homebrew                                                                    #
###############################################################################

# Install or update Homebrew
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Updating Homebrew..."
  brew update
fi
