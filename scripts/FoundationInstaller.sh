#!/bin/bash

# Introduction
# Menu

echo "==============================================="
echo "Welcome to the Foundation Installer Script"
echo -e "\t \t Jhunt 2024"
echo "==============================================="
# @TODO replace with carriage return; single line
echo ""  
DISTRO=$(cat /etc/*-release | grep -e ^ID | cut -d"=" -f2)
VERSION_ID=$(cat /etc/*-release | grep -e ^VERSION_ID | cut -d"=" -f2)
PKGMGR=""
echo "Distro: $DISTRO"
echo "Version ID: $VERSION_ID"
echo ""

# ##############################################
# Package Selector 
# ##############################################
function package_selector () {
if [ "$DISTRO" == "fedora" ]; then
	echo "This is Fedora; DNF package manager"
	PKGMGR="dnf"
	echo "Selecting $PKGMGR as package manager"
	sudo $PKGMGR -y install dnf-plugins-core
	sudo $PKGMGR clean all
	sleep 1

elif [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "ubuntu" ] ; then
	echo "This is Debian; APT package manager"
	PKGMGR="apt"
	echo "Selecting $PKGMGR as package manager"
	sudo $PKGMGR autoremove
	sudo $PKGMGR autoclean
	sleep 1
fi
}
package_selector

# ##############################################
# Update & Upgrade Function 
# ##############################################
function updateUpgrade () {
	echo "Attempting to update $DISTRO"
	sudo $PKGMGR update && sudo $PKGMGR upgrade -y
	echo "==========================="
	echo "==Performing Installations="
	echo "==========================="
}

# ##############################################
# Package Selector 
# ##############################################
function package_selector () {
if [ "$DISTRO" == "fedora" ]; then
	echo "This is Fedora; DNF package manager"
	PKGMGR="dnf"
	echo "Selecting $PKGMGR as package manager"
	sudo $PKGMGR -y install dnf-plugins-core
	sudo $PKGMGR clean all
	sleep 1

elif [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "ubuntu" ] ; then
	echo "This is Debian; APT package manager"
	PKGMGR="apt"
	echo "Selecting $PKGMGR as package manager"
	sudo $PKGMGR autoremove
	sudo $PKGMGR autoclean
	sleep 1
fi
}

# ##############################################
# Install Repos 
# ##############################################
function InstallRepos () {
	echo "Preparing to Install Repos based on Package Manager $PKGMGR"

	if [[ $PKGMGR == "dnf" ]]; then

		# ====== RPM Additional Repos ====== #
		echo "Installing RPM Fusion PreReqs"
		sleep 1
		sudo $PKGMGR install \
		https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

		sudo $PKGMGR install \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

		echo "Installing VSCode Repos"
		sudo $PKGMGR --import https://packages.microsoft.com/keys/microsoft.asc
		echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null 
	
		# ======Debian based Additional Repos ====== #
	elif [[ $PKGMGR == "apt" ]]; then
		sudo apt-add-repository --component non-free
		
		echo "Install VSCode Repos"
		sudo apt-get install wget gpg
		wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
		sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
		echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
		rm -f packages.microsoft.gpg
	fi

#	echo "Installing Wine PreReqs"
#	sleep 1
#	sudo $PKGMGR --import https://dl.winehq.org/wine-builds/winehq.key 
#	sudo $PKGMGR config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/$VERSION_ID/winehq.repo
	
}

# ##############################################
# Install Software 
# ##############################################
function InstallSoftware () {
	echo "In InstallSoftware() "
	echo "Installing $(wc -l packages) from Univsersal package list. "
	PKGS=$(cat packages | awk '{print}' ORS=' ')
	echo $PKGS
	echo $PKGMGR
	sudo $PKGMGR install $PKGS -y
	sleep 2
	# clear
		
	if [[ $PKGMGR == "dnf" ]]; then
		while read pkg; do
		echo $pkg
		sudo dnf install $pkg -y
		clear
		done < ./packages_rpm 
	elif [[ $PKGMGR == "apt" ]]; then
		while read pkg; do
		echo $pkg
		sudo apt install $pkg -y
		clear
		done < ./packages_deb
	fi
}

# ##############################################
# Install OnlyOffice 
# ##############################################
function OnlyOfficeInstall () {
	echo "Checking to see if onlyoffice.rpm exists..."

	if [[ $PKGMGR == "dnf" ]]; then
		OOinstallFile="onlyoffice.rpm"
	elif [[ $PKGMGR == "apt" ]]; then
		OOinstallFile="onlyoffice.deb"
	fi

	if [ -f $HOME/Downloads/$OOinstallFile ]; then
		echo "$OOinstallFile exists, nothing to do"
	else
		echo "Only Office Installer Not Found"
		echo "Downloading OnlyOffice"

		if [[ $PKGMGR == "dnf" ]]; then
			curl https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm -o ~/Downloads/onlyoffice.rpm
			sudo rpm -i ~/Downloads/onlyoffice.rpm
		elif [[ $PKGMGR == "apt" ]]; then
			curl https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb -o ~/Downloads/onlyoffice.deb
			sudo dpkg -i ~/Downloads/onlyoffice.deb
		fi
	fi
}
# ##############################################

function compileNeoVim () {
	git clone https://github.com/neovim/neovim ~/Downloads/neovim
	cd ~/Downloads/neovim/
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	sudo cp ~/Downloads/neovim/build/bin/nvim /usr/bin/
	sudo chown $USER: /usr/bin/nvim
}

# ##############################################
# Configure Applications
# ##############################################
function configApps () {
	echo "Adding .local/bin to \$PATH"
	export PATH="$HOME/.local/bin:$PATH"
	
	# Creating config Directories
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
	# ##############################################

	# Copying ~/.config based configurations
	echo "nvim > kickstart"
	git clone https://github.com/nvim-lua/kickstart.nvim $HOME/.config/nvim
	###
	echo "kitty conf > ~/.config/kitty/"
	cp -frv ../configs/kitty/ ~/.config

	# Flatpaks
	echo "Preparing to install FlatPaks"
	source install_flatpaks.sh
	fpInstall

	# Aliases
	# @TODO Create alias script
	# Debian calls bat 'batcat', let's fix this.
	if [[ $PKGMGR == "apt" ]]; then
		compileNeoVim
		echo "alias bat='batcat'" >> ~/.bashrc
	fi
	
	# alias to add a one-liner add/commit to a local git repos
	alias git-add-commit="git config --global alias.add-commit '!git add -A && git commit'"
	git config --global alias.add-commit '!git add -A && git commit'
	#
	
	echo "Setting up TLDR"
	tldr -u

	echo "Installing gnome-extensions-cli"
	pip3 install --upgrade gnome-extensions-cli

	echo "Adding right-click context options to Nautilus"
	cp ./VScode.sh $HOME/.local/share/nautilus/scripts/

	echo "Installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

	read menu_item

	if [[ $menu_item -eq 1 ]]; then
		source ./countdownConfirm.sh
		read_yn "Are you sure you want Install / Update" "y" 5 updateUpgrade

	elif [[ $menu_item -eq 2 ]]; then
		source ./countdownConfirm.sh
		read_yn "Are you sure you want install external repos?" "y" 5 InstallRepos

	elif [[ $menu_item -eq 3 ]]; then
		echo "Beginning Software Installs"
		InstallSoftware
		# source ./countdownConfirm.sh
		# read_yn "Are your ready to install base software packages" "y" 5 InstallSoftware


	elif [[ $menu_item -eq 4 ]]; then
		source ./countdownConfirm.sh
		read_yn "Do you want install Only Office" "y" 5 OnlyOfficeInstall
		
	elif [[ $menu_item -eq 5 ]]; then
		source ./countdownConfirm.sh
		read_yn "Do you want install Only Office" "y" 5 configApps
	
	elif [[ $menu_item -eq 9 ]]; then
		echo "Let's install it all!"
		updateUpgrades
		InstallRepos
		InstallSoftware
		OnlyOfficeInstall
		configApps

	else 
		return 1
	fi

	display_menu
}

display_menu
echo "Post Installation Notes"
echo "======================="
echo "run winecfg"

