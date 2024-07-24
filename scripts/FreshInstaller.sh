#!/bin/bash
#Identify the OS / Distro ############################
DISTRO=$(cat /etc/*-release | grep -e ^ID | cut -d"=" -f2)
VERSION_ID=$(cat /etc/*-release | grep -e ^VERSION_ID | cut -d"=" -f2)
PKGMGR=""
echo "Distro: $DISTRO"
echo "Version ID: $VERSION_ID"
sleep 2
######################################################

function FreshInstall () {
	echo "Entering main Install Function"
	##
	function updateupgrade () {
		echo "Attempting to update $DISTRO"
		sudo dnf clean all
		sudo $PKGMGR update && sudo $PKGMGR upgrade -y
		sudo $PKGMGR -y install dnf-plugins-core
		echo "==========================="
		echo "==Performing Installations="
		echo "==========================="
	}
	
	### InstallRepos BEGIN ###
	
	function InstallRepos () {
		# ====== RPM Additional Repos Repos ====== #
		echo "Installing RPM Fusion PreReqs"
		sleep 2
		sudo $PKGMGR install \
		https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

		sudo $PKGMGR install \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
		
		echo "Installing Wine PreReqs"
		sleep 2
		sudo $PKGMGR --import https://dl.winehq.org/wine-builds/winehq.key 
		sudo $PKGMGR config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/$VERSION_ID/winehq.repo

		sudo $PKGMGR --import https://packages.microsoft.com/keys/microsoft.asc
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
			sudo rpm -i ~/Downloads/onlyoffice.rpm
		fi
	}
	## OnlyOfficeInstall END

	# ====== Configure Installed Apps ====== #
	function configApps () {
		echo "Adding .local/bin to \$PATH"
		export PATH="$HOME/.local/bin:$PATH"

		echo "Now Configuring Apps..."
		sleep 1

		echo "Creating directories as necessary"
		echo "neovim: $HOME/.config/nvim"
		mkdir $HOME/.config/nvim
		
		###
		echo "nvim > kickstart"
		git clone https://github.com/nvim-lua/kickstart.nvim $HOME/.config/nvim

		echo "installing flatpak remote repos"
		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

		flatpak install us.zoom.Zoom
		flatpak install org.nickvision.tubeconverter

		###
		echo "TLDR"
		tldr -u

		echo "Adding git add-commit alias"
		echo "Now we can add and commit in one line like this:"
		echo "\$ git add-commit -m 'message' "
		git config --global alias.add-commit '!git add -A && git commit'
		alias git-add-commit="git config --global alias.add-commit '!git add -A && git commit'"

		echo "Installing gnome-extensions-cli"
		pip3 install --upgrade gnome-extensions-cli

		echo "Adding right-click context options to Nautilus"
		cp ./VScode.sh /home/jhunt/.local/share/nautilus/scripts/

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
read -p "Config Apps (Y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	configApps
fi

}

## Entry Point ##
if [ "$DISTRO" == "fedora" ]; then
	echo "This is Fedora; DNF package manager"
	PKGMGR="dnf"
	echo "Selecting $PKGMGR as package manager"
	sleep 1
	FreshInstall

elif [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "ubuntu" ] ; then
	echo "This is Debian; APT package manager"
	PKGMGR="apt"
	echo "Selecting $PKGMGR as package manager"
	sleep 1
fi
###################################

echo "Post Installation Items"
echo "run winecfg"
