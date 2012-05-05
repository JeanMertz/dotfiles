#!/bin/bash


# Get given parameters and set correct values
# $1 = location where dotfiles are stored (defaults to ~/dotfiles)
if [ -z "$1" ]; then
	dotfiles="${HOME}/dotfiles"
else
	dotfiles="$1"
fi


# Set base path variables
WORK_DIR=/tmp/jean-imac-`date +%s`
DOTFILES_DIR="$dotfiles"
BOOTSTRAP_DIR=$( cd "$( dirname "$0" )" && pwd )
DROPBOX_DIR="$(bash ${BOOTSTRAP_DIR}/utilities/get_dropbox_folder.sh)"


# Source all functions used throughout this script
source "${BOOTSTRAP_DIR}/utilities/bootstrap_functions.sh"


# Here we go!
echo -e "\033[1;32mInitializing Mac configuration...\033[0m"


# Create a tmp dir for all downloads/etc to go
mkdir -p $WORK_DIR
cd $WORK_DIR


# Check if Dropbox is installed
log "Checking for Dropbox"
if [ ! -d "${HOME}/Dropbox" ]; then
	cd $WORK_DIR
	curl -L -o Dropbox.dmg https://www.dropbox.com/download?plat=mac
	hdiutil mount Dropbox.dmg
	cp -R '/Volumes/Dropbox Installer/Dropbox.app' '/Applications/Dropbox.app'
	hdiutil unmount "/Volumes/Dropbox Installer"
	rm Dropbox.dmg
	open /Applications/Dropbox.app &
	check_for_dropbox

	$DROPBOX_DIR="$(bash ${BOOTSTRAP_DIR}/utilities/get_dropbox_folder.sh)"

	log "Dropbox installed, continuing..."
else
	log "Dropbox found, continuing..."
fi


# Check if Xcode/Git is installed
log "Checking for Git"
if [ ! $(which git 2>/dev/null) ]; then
	error "Git not found"
	check_for_xcode
	log "Git installed, continuing..."
else
	log "Git found, continuing..."
fi


# Install Homebrew and fix xcode locations
log "Checking for Homebrew"
if [ ! $(which brew 2>/dev/null) ]; then
	/usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
	echo "export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/python:$PATH" >> "${HOME}/.bash_profile"
	source "${HOME}/.bash_profile"
	sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
	log "Homebrew installed, updating..."
else
	log "Homebrew found, checking..."
fi


# Make sure Homebrew works as expected
brew_doctor=$(brew doctor)
if [ "$?" -ne "0" ]; then
	log $brew_doctor
	pause "Homebrew returned an error. You can fix this problem now or deal with it later. Press [enter] to continue..."
else
	log $brew_doctor
fi


# Install rbenv
log "Checking for rbenv..."
if [ ! $(which rbenv 2>/dev/null) ]; then
	log "Rbenv not found, installing..."
	brew install rbenv

	log "Adding rbenv path to .bash_profile"
	echo 'eval "$(rbenv init -)"' >> "${HOME}/.bash_profile"
	source "${HOME}/.bash_profile"

	log "Rbenv installed, continuing..."
else
	log "Rbenv found, continuing..."
fi


# Install ruby-build
log "Checking for ruby-build..."
if [ ! $(which ruby-build 2>/dev/null) ]; then
	log "Ruby-build not found, installing..."
	brew install ruby-build

	log "Ruby-build installed, continuing..."
else
	log "Ruby-build found, continuing..."
fi


# Print current installed ruby versions
log "Current installed Ruby versions:"
log "$(rbenv versions)"


# Install latest ruby-build
ask "Do you want to install a new Ruby version? [yes/no]"
read confirm_install
ask_for_installation


# Install chef-solo for further system setup
if [ ! $(which chef-solo 2>/dev/null) ]; then
	log "Installing chef gem..."
	gem install chef --no-ri --no-rdoc >/dev/null || exit 1
fi


# Symlink dotfiles directory
if [ ! -d "$DOTFILES_DIR" ]; then
	log "Creating symlink from $DOTFILES_DIR to ${HOME}/Dropbox/dotfiles"
	ln -s "${HOME}/Dropbox/dotfiles" "$DOTFILES_DIR"
else
	log "Existing dotfiles found, checking symlink target location..."
	if [ ! $(readlink "$DOTFILES_DIR" 2>/dev/null) ]; then
		log "$DOTFILES_DIR is not a symlink, backing up to ${DOTFILES_DIR}_bak"
		mv "$DOTFILES_DIR" "${DOTFILES_DIR}_bak"

		log "Creating symlink from $DOTFILES_DIR to ${HOME}/Dropbox/dotfiles"
		ln -s "${HOME}/Dropbox/dotfiles" "$DOTFILES_DIR"
	else
		if [[ $(readlink "$DOTFILES_DIR" 2>/dev/null) == "${HOME}/Dropbox/dotfiles" ]]; then
			log "Correct symlink already exists, no action taken"
		else
			log "Symlink exists but points to incorrect location ($(readlink \"$DOTFILES_DIR\"))."
			log "Backing up to ${DOTFILES_DIR}_bak"
			mv "$DOTFILES_DIR" "${DOTFILES_DIR}_bak"

			log "Creating symlink from $DOTFILES_DIR to ${HOME}/Dropbox/dotfiles"
			ln -s "${HOME}/Dropbox/dotfiles" "$DOTFILES_DIR"
		fi
	fi
fi
log "$DOTFILES_DIR symlink created, continuing..."


# Run chef-solo command
log "Starting chef-solo run..."
chef-solo -c "${DOTFILES_DIR}/chef/config/solo.rb"

if [ "$?" -ne "0" ]; then
  exit
fi

# Symlink dotfiles in homedir
cd  "${DOTFILES_DIR}/symlinks"
source "${DOTFILES_DIR}/utilities/symlink_dotfiles.sh"
log "All files in ${DOTFILES_DIR}/symlinks have been symlinked to ${HOME}"


# Set git username and e-mail
if [ ! "$(git config --global user.name 2>/dev/null)" ]; then
	ask "Git Full name?"
	read git_username
	git config --global user.name "$git_username"

	ask "Git email?"
	read git_email
	git config --global user.email "$git_email"
fi


# Set up SHH for github access
if [ ! -f "${HOME}/.ssh/id_rsa.pub" ]; then
	log "Setting up SSH for Github access"

	ssh-keygen -t rsa -C "$git_email"

	log "This is your id_rsa.pub value:"
	cat "${HOME}/.ssh/id_rsa.pub"

	pause "Please add the above key to Github. Press [enter] to continue..."
fi


# Clean up temporary directory
rm -R $WORK_DIR
