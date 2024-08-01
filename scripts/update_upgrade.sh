#!/bin/bash

#Argument 1 intended to be string indicating package mgr
# IE dnf, apt, yay etc.
function updateupgrade () {
		echo "Attempting to update $DISTRO"
		sudo $1 clean all
		sudo $PKGMGR update && sudo $PKGMGR upgrade -y
		sudo $PKGMGR -y install dnf-plugins-core
		echo "==========================="
		echo "==Performing Installations="
		echo "==========================="
	}
	
