#!/bin/bash
#Identify the OS / Distro ############################
DISTRO=$(cat /etc/*-release | grep -e ^ID | cut -d"=" -f2)
VERSION_ID=$(cat /etc/*-release | grep -e ^VERSION_ID | cut -d"=" -f2)
echo "Distro: $DISTRO"
echo "Version ID: $VERSION_ID"
sleep 2
######################################################

function FreshInstall () {
	echo "Entering main Install Function"
	##
	function updateupgrade () {
		echo "Attempting to update Fedora"
		sudo dnf clean all
		sudo dnf update -y
		sudo dnf -y install dnf-plugins-core
		echo "==========================="
		echo "==Performing Installations="
		echo "==========================="
	}
	
	### InstallRepos BEGIN ###
	
	function InstallRepos () {
		# ====== RPM Additional Repos Repos ====== #
		echo "Installing RPM Fusion PreReqs"
		sleep 2
		sudo dnf install \
		https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

		sudo dnf install \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
		
		echo "Installing Wine PreReqs"
		sleep 2
		sudo rpm --import https://dl.winehq.org/wine-builds/winehq.key 
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/$VERSION_ID/winehq.repo

		sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
		echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null 
	}
		### InstallRepos END ###
	
	function InstallSoftware () {
		#!/bin/bash
		echo "Installing $(wc -l packages) from package list. "
		while read pkg; do
		echo $pkg
		sudo dnf install $pkg -y
		done < ./packages 
	}
	
	
	function OnlyOfficeInstall () {
		# ====== Only Office Install ====== #
		# # Refactor to move after primary package downloads
		echo "Checking to see if onlyoffice.rpm exists..."
		OOinstallFile="onlyoffice.rpm"
		
		if [ -f $HOME/Downloads/$OOinstallFile ]; then
			echo "$OOinstallFile exists, nothing to do"
		else
			echo "Only Office Installer Not Found"
			echo "Downloading OnlyOffice"
			curl https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm -o ~/Downloads/onlyoffice.rpm
			rpm -i ~/Downloads/onlyoffice.rpm
		fi
	}
	## OnlyOfficeInstall END

	# ====== Configure Installed Apps ====== #
	function configApps () {
		echo "Now Configuring Apps..."
		sleep 2
		
		###
		echo "nvim > kickstart"
		mkdir $HOME/.config/nvim
		git clone https://github.com/nvim-lua/kickstart.nvim $HOME/.config/nvim

		###
		echo "TLDR"
		tldr -u 
	} #configApps END
	
# ====== Gnome Extensions ====== #

# ====== Function Launchers ====== #
updateupgrade

read -p "Install Repos? (Y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
InstallRepos
fi

read -p "Install Software Base Packages? (Y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
InstallSoftware
fi

read -p "Install Only Office? (Y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	OnlyOfficeInstall
fi
}

## Entry Point ##
if [ "$DISTRO" == "fedora" ]; then
	echo "This is Fedora; DNF package manager"
	FreshInstall

elif [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "ubuntu" ] ; then
	echo "This is Debian; APT package manager"
	echo "Attempting to update"
	sudo apt update -y
fi
###################################

echo "Post Installation Items"
echo "run winecfg"
