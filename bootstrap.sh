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
