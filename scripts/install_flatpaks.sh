#!/bin/bash
function fpInstall () {
	
	echo "installing flatpak remote repos"
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	echo "Installing Flatseal"
	flatpak install -y flathub com.github.tchx84.Flatseal
	
	echo "Installing Parabolic (flatpak)"
	flatpak install -y us.zoom.Zoom
	flatpak install -y org.nickvision.tubeconverter

	echo "Installing Proton Pass"
	flatpak install -y flathub me.proton.Pass

	echo "Installing Impression"
	flatpak install -y flathub io.gitlab.adhami3310.Impression
	
	echo "Installing VSCode"
	flatpak install -y flathub com.visualstudio.code

	echo "Installing Extension Manager by Matthew Jakeman"
	flatpak install -y flathub com.mattjakeman.ExtensionManager

	echo "Installing Brave Browser"
	flatpak install -y flathub com.brave.Browser

	echo "Installing Steam"
	flatpak install -y flathub com.valvesoftware.Steam
}

fpInstall
