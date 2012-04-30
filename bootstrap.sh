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




function ask_if_installed {
	ask "Did $1 install correctly? [yes/no]"
	read installed
	if [ $installed == "no" ]; then
		eval install_\$1
	else if [ ! $installed == "yes" ]; then
		ask_if_installed $1
	fi
	fi
}

function ask_for_installation {
	if [ $confirm_install == "yes" ]; then
		install_ruby
		log $(ruby -v)

		log "Updating Rubygems..."
		gem update --system >/dev/null
		log "Current Rubygem version: $(gem --version)"

		gem install rbenv-rehash --no-ri --no-rdoc >/dev/null || exit 1

	else if [ ! $confirm_install == "no" ]; then
		ask_for_installation
	fi
	fi
}

function install_ruby {
	rbenv install
	ask "Please type the version of ruby you want to install..."
	read ruby_version
	rbenv install $ruby_version

	ask_if_installed "ruby"
	rbenv global $ruby_version
	rbenv rehash
}

function check_for_dropbox {
	if [ ! -d ~/Dropbox ]; then
		pause "Please set up Dropbox (login and sync dotfiles/). Press [enter] to continue..."
		check_for_dropbox
	fi
}

function check_for_xcode {
if [ ! $(which git 2>/dev/null) ]; then
		pause "Please install Xcode 4.3 and the Xcode Developer Tools. Press [enter] to continue..."
		check_for_xcode
	fi
}

echo -e "\033[1;32mInitializing Mac configuration...\033[0m"

WORK_DIR=/tmp/jean-imac-`date +%s`
mkdir -p $WORK_DIR
cd $WORK_DIR


# Check if Dropbox is installed
log "Checking for Dropbox"
if [ ! -d ~/Dropbox ]; then
	cd /tmp
	curl -L -o Dropbox.dmg https://www.dropbox.com/download?plat=mac
	hdiutil mount Dropbox.dmg
	cp -R '/Volumes/Dropbox Installer/Dropbox.app' '/Applications/Dropbox.app'
	hdiutil unmount "/Volumes/Dropbox Installer"
	rm Dropbox.dmg
	open /Applications/Dropbox.app &
	check_for_dropbox
	log "Dropbox installed, continuing..."
else
	log "Dropbox found, continuing..."
fi


# Check if Xcode is installed
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
	echo "export PATH=/usr/local/bin:$PATH" >> ~/.bash_profile
	source ~/.bash_profile
	sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
	log "Homebrew installed, updating..."
else
	log "Homebrew found, updating..."
fi


# Make sure Homebrew works as expected
brew update >/dev/null
log $(brew doctor)


# Install latest version of Git
if [[ ! $(brew which git 2>/dev/null) ]]; then
	log "Installing latest version of git..."
	brew install git
	log "Git installed, current version: $(git --version)"
fi


# Install latest version of Git-flow
if [[ ! $(brew which git-flow 2>/dev/null) ]]; then
	log "Installing latest version of git-flow..."
	brew install git-flow
	log "Git-flow installed"
fi


# Set git username and e-mail
if [[ ! $(git config --global user.name 2>/dev/null) ]]; then
	ask "Git Full name?"
	read git_username
	git config --global user.name $git_username

	ask "Git email?"
	read git_email
	git config --global user.email $git_email
fi


# Install rbenv
log "Checking for rbenv..."
if [ ! $(which rbenv 2>/dev/null) ]; then
	log "Rbenv not found, installing..."
	brew install rbenv

	log "Adding rbenv path to .bash_profile"
	echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
	source ~/.bash_profile

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


# Install latest ruby-build
ask "Do you want to install a new Ruby version? [yes/no]"
read confirm_install
ask_for_installation


# Install chef-solo for further system setup
if [ ! $(which chef-solo 2>/dev/null) ]; then
	log "Installing chef gem..."
	gem install chef --no-ri --no-rdoc >/dev/null || exit 1
fi


# Set up SHH for github access
if [ ! -f ~/.ssh/id_rsa.pub ]; then
	log "Setting up SSH for Github access"
	ask "Provide e-mail address for SSH"
	read ssh_email

	ssh-keygen -t rsa -C $ssh_email

	log "This is your id_rsa.pub value:"
	cat ~/.ssh/id_rsa.pub

	pause "Please add the above key to Github. Press [enter] to continue..."
fi


# Symlink .dotfiles
if [ ! -d ~/.dotfiles ]; then
	log "Creating symlink from ~/.dotfiles to ~/Dropbox/dotfiles"
	ln -s ~/Dropbox/dotfiles ~/.dotfiles
else
	log "Existing dotfiles found, checking symlink target location..."
	if [ ! $(readlink ~/.dotfiles 2>/dev/null) ]; then
		log "~/.dotfiles is not a symlink, backing up to ~/dotfiles_bak"
		mv ~/.dotfiles ~/dotfiles_bak

		log "Creating symlink from ~/.dotfiles to ~/Dropbox/dotfiles"
		ln -s ~/Dropbox/dotfiles ~/.dotfiles
	else
		if [[ $(readlink ~/.dotfiles 2>/dev/null) == */Dropbox/dotfiles ]]; then
			log "Correct symlink already exists, no action taken"
		else
			log "Symlink exists but points to incorrect location ($(readlink ~/.dotfiles))."
			log "Backing up to ~/dotfiles_bak"
			mv ~/.dotfiles ~/dotfiles_bak

			log "Creating symlink from ~/.dotfiles to ~/Dropbox/dotfiles"
			ln -s ~/Dropbox/dotfiles ~/.dotfiles
		fi
	fi
fi
log "Symlink created, continuing..."


# Run chef-solo
log "Starting chef-solo run..."
cd ~/.dotfiles/chef
chef-solo -c config/solo.rb -j config/node.json
