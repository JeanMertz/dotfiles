#!/bin/bash

function log {
  echo -e "\033[1;31m>> \033[0;34m$*\033[0m"
}
function error {
  echo -e "\033[1;31m!! \033[1;31m$*\033[0m"
}
function ask {
  echo -e "\033[1;32m?? \033[0;32m$*\033[0m"
}
function pause {
   read -p "$*"
}


echo -e "\033[1;32mInitializing Jean-iMac...\033[0m"

WORK_DIR=/tmp/jean-imac-`date +%s`
mkdir -p $WORK_DIR
cd $WORK_DIR

# Check if Xcode is installed
log "Checking for Git"
if [ ! $(which git 2>/dev/null) ]; then
	error "Git not found"
	error "Please install Xcode 4.3 and the Xcode Developer Tools"
	exit
fi
log "Git found, continuing..."


# Install Homebrew and fix xcode locations
log "Checking for Homebrew"
if [ ! $(which brew 2>/dev/null) ]; then
	/usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
	echo "export PATH=/usr/local/bin:$PATH" >> ~/.bash_profile
	source ~/.bash_profile
	sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
fi

# Make sure brew works as expected
brew update >/dev/null
log $(brew doctor)


# Install latest version of Git
if [[ ! $(brew which git 2>/dev/null) ]]; then
	log "Installing latest version of git..."
	brew install git
	log "Current git version: $(git --version)"
fi


# Install latest version of Git-flow
if [[ ! $(brew which git-flow 2>/dev/null) ]]; then
	log "Installing latest version of git-flow..."
	brew install git-flow
	log "Git-flow installed"
fi
