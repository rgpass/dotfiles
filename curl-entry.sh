#!/usr/bin/env bash

# Run this script with:
# $ curl https://raw.githubusercontent.com/rgpass/dotfiles/master/curl-entry.sh | bash

# Create and move into a projects directory
mkdir -p "${HOME}/projects"
cd "${HOME}/projects"

# Clone the project
git clone https://github.com/rgpass/dotfiles.git

# Move into the project directory
cd dotfiles

# Run the install script
sh install.sh
