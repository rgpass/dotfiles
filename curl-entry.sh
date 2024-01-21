#!/usr/bin/env bash

# Run this script with:
# $ curl https://raw.githubusercontent.com/rgpass/dotfiles/master/curl-entry.sh | bash

# Create and move into a scripts directory
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
  echo "> Cloning dotfiles..."
  git clone https://github.com/rgpass/dotfiles.git
  cd dotfiles
end

# Run the install script
sh install.sh
