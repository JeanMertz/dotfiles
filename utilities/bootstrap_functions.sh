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
	if [ "$installed" == "no" ]; then
		eval install_\$1
	else if [ ! "$installed" == "yes" ]; then
		ask_if_installed $1
	fi
	fi
}

function activate_trim_support {
	if [ "$confirm_trim" == "yes" ]; then
		log "Enabling TRIM Support for OS X..."
		log "  Backing up kernel file..."
		sudo cp /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage.original

		log "  Patching kernel..."
		sudo perl -pi -e 's|(\x52\x6F\x74\x61\x74\x69\x6F\x6E\x61\x6C\x00{1,20})[^\x00]{9}(\x00{1,20}\x51)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage

		log "  Clearing system kernel extension cache..."
		sudo kextcache -system-prelinked-kernel
		sudo kextcache -system-caches
		log "TRIM Support enabled."

		log ""
		log "In the future, if you want to disable trim support run the following commands:"
		log "  sudo perl -pi -e 's|(\x52\x6F\x74\x61\x74\x69\x6F\x6E\x61\x6C\x00).{9}(\x00\x51)|$1\x41\x50\x50\x4C\x45\x20\x53\x53\x44$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage"
		log "  sudo kextcache -system-prelinked-kernel"
		log "  sudo kextcache -system-caches"

		log ""
		log "If something goes horribly wrong, restore the backed up kernel file:"
		log "sudo cp /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage.original /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage"

		log ""
		log "You WILL need to reapply this patch whenever OS X is updated. Rerunning bootstrap.sh should be enough."
		log ""

	else
		log "Leaving TRIM support disabled..."
	fi
}

function ask_for_installation {
	if [ "$confirm_install" == "yes" ]; then
		install_ruby

		log "Updating Rubygems..."
		gem update --system >/dev/null
		log "Current Rubygem version: $(gem --version)"

		gem install rbenv-rehash --no-ri --no-rdoc >/dev/null || exit 1

	else if [ ! "$confirm_install" == "no" ]; then
		ask_for_installation
	fi
	fi
}

function install_ruby {
	rbenv install
	ask "Please type the version of ruby you want to install..."
	read ruby_version
	rbenv install $ruby_version

	log $(ruby -v)
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
