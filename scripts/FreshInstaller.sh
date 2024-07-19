#!/bin/bash
#Identify the OS / Distro #########
DISTRO=$(cat /etc/*-release | grep -e ^ID | cut -d"=" -f2)
VERSION_ID=$(cat /etc/*-release | grep -e ^VERSION_ID | cut -d"=" -f2)
echo "Distro: $DISTRO"
echo "Version ID: $VERSION_ID"

sleep 5

function FreshInstall () {
	function updateupgrade () {

	echo "Attempting to update Fedora"
	sudo dnf clean all
	sudo dnf update -y
	sudo dnf -y install dnf-plugins-core
	echo "==========================="
	echo "==Performing Installations="
	echo "==========================="

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

	# ====== Software ====== #
	sudo dnf install -y \
	kitty lolcat python3 python3-pip\
	mc ranger neovim bpytop tree bat\
	zsh git curl wget lynx ffmpeg libmp3lame\
	figlet easytag tldr geary obs-studio \
	steam  winehq-stable perl gnome-tweaks\
	dejavu-sans-fonts dejavu-serif-fonts libXScrnSaver \
	nautilus-dropbox-* keepassxc gnome-extensions
	}

	# ====== Gnome Extensions ====== #
	

	echo "Downloading OnlyOffice"
	curl https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm -o ~/Downloads/onlyoffice.rpm
	rpm -i ~/Downloads/onlyoffice.rpm
	#@TODO confirm the auto yes flag

function configApps () {
	git clone https://github.com/nvim-lua/kickstart.nvim $HOME/.config/nvim

	tldr -u

}

	updateupgrade 
}

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
