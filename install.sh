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

DOTFILES_ROOT="${HOME}/scripts/dotfiles"

###############################################################################
# Standard directories                                                        #
###############################################################################

echo "> Creating standard directories..."
mkdir -p "${HOME}/companies"
mkdir -p "${HOME}/projects"
mkdir -p "${HOME}/sandbox"
mkdir -p "${HOME}/scripts"

###############################################################################
# z frecent algo                                                              #
###############################################################################

if test ! $(which z); then
  echo "> Installing z..."
  curl -o "${HOME}/scripts/z.sh" https://raw.githubusercontent.com/rupa/z/master/z.sh
else
  echo "> z already exists, skipping..."
fi

###############################################################################
# Oh My Zsh                                                                   #
###############################################################################

# Install Oh My Zsh if needed
if [ -d "${HOME}/.oh-my-zsh" ]; then
  echo "> Oh My Zsh already installed, skipping..."
else
  echo "> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Symlinking .zshrc
if [ -f "${HOME}/.zshrc" ]; then
  echo "> .zshrc already exists, skipping..."
else
  echo "> Symlinking .zshrc..."
  ln -s "${DOTFILES_ROOT}/.zshrc" "${HOME}/.zshrc"
fi

###############################################################################
# Homebrew                                                                    #
###############################################################################

# Install or update Homebrew
if test ! $(which brew); then
  echo "> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "> Updating Homebrew..."
  brew update
fi

# Install Homebrew packages
echo "> Installing Homebrew packages..."
brew bundle

# Remove Brewfile versioning
rm Brewfile.lock.json

###############################################################################
# Mac OSX system preferences                                                  #
###############################################################################

echo "> Setting Mac OSX system preferences..."
sh system-preferences.sh

###############################################################################
# git and GitHub                                                              #
###############################################################################

# Symlinking .gitconfig
if [ -f "${HOME}/.gitconfig" ]; then
  echo "> .gitconfig already exists, skipping..."
else
  echo "> Symlinking .gitconfig..."
  ln -s "${DOTFILES_ROOT}/.gitconfig" "${HOME}/.gitconfig"
fi

# Check if logged into GitHub
if gh auth status | grep -q "Logged in to github.com"; then
  echo "> Already logged into GitHub, skipping..."
else
  echo "> Not logged into GitHub, logging in..."
  gh auth login
fi

###############################################################################
# Programming languages                                                       #
###############################################################################

if [ -f "${HOME}/.tool-versions" ]; then
  echo "> .tool-versions already exists, skipping..."
else
  echo "> Symlinking .tool-versions..."
  ln -s "${DOTFILES_ROOT}/.tool-versions" "${HOME}/.tool-versions"
fi

echo "> Installing latest NodeJS..."
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

echo "> Installing latest Ruby..."
asdf plugin add ruby
asdf install ruby latest
asdf global ruby latest

###############################################################################
# Finish                                                                      #
###############################################################################

echo "> Done!"
source "${HOME}/.zprofile"
