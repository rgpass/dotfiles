#!/usr/bin/env bash

# Run this script with:
# $ curl https://raw.githubusercontent.com/rgpass/dotfiles/master/curl-entry.sh | bash

###############################################################################
# Colors                                                                      #
###############################################################################
yellow() {
  echo -e "\033[1;33m$1\033[0m"
}

###############################################################################
# Install Xcode                                                               #
###############################################################################

yellow "> Installing Xcode (which installs git)..."
yellow "> If the script fails, rerun after Xcode is installed"
xcode-select --install

###############################################################################
# Install Xcode                                                               #
###############################################################################


# Create and move into a scripts directory
yellow "> Make scripts directory and moving in..."
mkdir -p "${HOME}/scripts"
cd "${HOME}/scripts"

# Clone the project
# If dotfiles directory exists, cd into it and git pull
# Otherwise, clone the project
if [ -d "${HOME}/scripts/dotfiles" ]; then
  yellow "> dotfiles already exists, updating..."
  cd dotfiles
  git pull
else
  yellow "> Cloning dotfiles into ${PWD}..."
  git clone https://github.com/rgpass/dotfiles.git
  cd dotfiles
fi

# Run the install script
sh install.sh
