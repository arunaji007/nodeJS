#!/bin/bash -ex

# Output user data logs into a separate file for debugging
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

# Download and install NVM (latest version)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install Node.js version 20
nvm install 20

# Upgrade apt
sudo apt update && sudo apt upgrade -y

# Install Git
sudo apt install git -y

cd /home/ubuntu  # Change to the appropriate home directory for Ubuntu users

# Get source code from GitHub
git clone https://github.com/arunaji007/nodeJS

# Get into project directory
cd nodeJS

# Give permission
sudo chmod -R 755 .

# Install Node modules
npm install

# Start the app
node app.js > app.out.log 2> app.err.log < /dev/null &
