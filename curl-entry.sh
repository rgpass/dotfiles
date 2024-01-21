#!/usr/bin/env bash

# Run this script with:
# $ curl https://raw.githubusercontent.com/rgpass/dotfiles/master/curl-entry.sh | bash

###############################################################################
# Install Xcode                                                               #
###############################################################################

# If Xcode is installed, skip
# Otherwise, prompt the user that they will need to recurl after installing it
if test ! $(which xcode-select); then
  echo "> Xcode not installed, please install it and rerun this script..."
  echo "The command to run is \`xcode-select --install\`"
  exit 1
else
  echo "> Xcode already installed, skipping..."
fi

# Create and move into a scripts directory
echo "> Make scripts directory and moving in..."
mkdir -p "${HOME}/scripts"
cd "${HOME}/scripts"

# Clone the project
# If dotfiles directory exists, cd into it and git pull
# Otherwise, clone the project
if [ -d "${HOME}/scripts/dotfiles" ]; then
  echo "> dotfiles already exists, updating..."
  cd dotfiles
  git pull
else
  echo "> Cloning dotfiles into ${PWD}..."
  git clone https://github.com/rgpass/dotfiles.git
  cd dotfiles
fi

# Run the install script
sh install.sh
