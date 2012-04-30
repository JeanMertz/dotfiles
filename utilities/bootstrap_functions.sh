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
	if [ ! -d "${HOME}/Dropbox" ]; then
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