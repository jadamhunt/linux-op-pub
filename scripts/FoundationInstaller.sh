#!/bin/bash

# Introduction
# Menu

"==============================================="
echo "Welcome to the Foundation Installer Script"
echo "\t \t Jhunt 2024"
"==============================================="
# @TODO replace with carriage return; single line
echo ""  
echo ""
echo ""

DISTRO=$(cat /etc/*-release | grep -e ^ID | cut -d"=" -f2)
VERSION_ID=$(cat /etc/*-release | grep -e ^VERSION_ID | cut -d"=" -f2)
PKGMGR=""
echo "Distro: $DISTRO"
echo "Version ID: $VERSION_ID"

echo ""
echo ""
echo ""

function updateUpgrade () {
	echo "Attempting to update $DISTRO"
	sudo dnf clean all
	sudo $PKGMGR update && sudo $PKGMGR upgrade -y
	sudo $PKGMGR -y install dnf-plugins-core
	echo "==========================="
	echo "==Performing Installations="
	echo "==========================="
}
########## package_selector ##########
function package_selector () {
if [ "$DISTRO" == "fedora" ]; then
	echo "This is Fedora; DNF package manager"
	PKGMGR="dnf"
	echo "Selecting $PKGMGR as package manager"
	sleep 1

elif [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "ubuntu" ] ; then
	echo "This is Debian; APT package manager"
	PKGMGR="apt"
	echo "Selecting $PKGMGR as package manager"
	sleep 1
fi
}

########## install_repos ##########

function InstallRepos () {
	# ====== RPM Additional Repos Repos ====== #
	echo "Installing RPM Fusion PreReqs"
	sleep 1
	sudo $PKGMGR install \
	https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

	sudo $PKGMGR install \
	https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	
	echo "Installing Wine PreReqs"
	sleep 1
	sudo $PKGMGR --import https://dl.winehq.org/wine-builds/winehq.key 
	sudo $PKGMGR config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/$VERSION_ID/winehq.repo
	
	echo "Installing VSCode Repos"
	sudo $PKGMGR --import https://packages.microsoft.com/keys/microsoft.asc
	echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null 
}

########## InstallSoftware ##########
function InstallSoftware () {
	#!/bin/bash
	echo "Installing $(wc -l packages) from package list. "
	while read pkg; do
	echo $pkg
	sudo dnf install $pkg -y
	clear
	done < ./packages 
}

########## OnlyOfficeInstall ##########
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


function configApps () {
	echo "Adding .local/bin to \$PATH"
	export PATH="$HOME/.local/bin:$PATH"

	echo "Now Configuring Apps..."
	sleep 1

	echo "Creating directories as necessary:"
	echo "=========="
	echo "Installing NeoVim config folder"
	echo "neovim: $HOME/.config/nvim"
	pathCheck d $HOME/.config/nvim
	###
	echo "Installing Kitty config folder"
	echo "neovim: $HOME/.config/kitty"
	pathCheck d $HOME/.config/kitty
	echo "========="

	echo "nvim > kickstart"
	git clone https://github.com/nvim-lua/kickstart.nvim $HOME/.config/nvim
	
	echo "kitty conf > ~/.config/kitty/"
	cp -r ../configs/kitty/ $HOME/.config/kitty/

	echo "installing flatpak remote repos"
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	echo "Installing Parabolic (flatpak)"
	flatpak install us.zoom.Zoom
	flatpak install org.nickvision.tubeconverter

	echo "Installing Proton Pass"
	flatpak install flathub.me.proton.Pass

	###
	echo "Setting up TLDR"
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

function pathCheck () {
	echo "Checking for path $2 of type: $1"
	# $1 params: d = directory, f = file
	# $2 params: absolute path
	if [ -$1 $2 ]; then
		echo "directory / file exists."
	else
		mkdir -p $2
 	fi
}

function display_menu () {
	echo "+++++++++++++++++++++++++++"
	echo "---------------------------"
	echo " 1 - Update / Upgrade      "
	echo " 2 - Install Ext. Repos    "
	echo " 3 - Install Base Sofware  "
	# Add List Base Sofware 
	echo " 4 - Install OnlyOffice    "
	echo " 5 - Config Installed Apps "
	echo " 9 - ^ Perform All ^	 "
	echo " 0 - Quit                  "
	echo "---------------------------"
	echo "+++++++++++++++++++++++++++"
}

display_menu

read menu_item

if [ $menu_item -eq 1 ]
then
	package_selector 
	source ./countdownConfirm.sh
	read_yn "Are you sure you want Install / Update" "y" 5 updateUpgrade

elif [ $menu_tem -eq 2 ]; then
	source ./countdownConfirm.sh
	read_yn "Are you sure you want install external repos?" "y" 5 InstallRepos

elif [ $menu_tem -eq 3 ]; then
	source ./countdownConfirm.sh
	read_yn "Are your ready to install base software packages" "y" 5 InstallSoftware

elif [ $menu_tem -eq 4 ]; then
	source ./countdownConfirm.sh
	read_yn "Do you want install Only Office" "y" 5 OnlyOfficeInstall
	
elif [ $menu_tem -eq 5 ]; then
	source ./countdownConfirm.sh
	read_yn "Do you want install Only Office" "y" 5 configApps
else
	break
fi


echo "Post Installation Notes"
echo "======================="
echo "run winecfg"

