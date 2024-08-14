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

	echo "Lorem"
	flatpak install -y flathub org.gnome.design.Lorem

	echo "Cheese"
	flatpak install -y flathub org.gnome.Cheese

	echo "Thunderbird"
	flatpak install -y flathub org.mozilla.Thunderbird

	echo "PacketTracer"
	flatpak install -y flathub com.cisco.PacketTracer

	echo "Todoist"
	flatpak install -y flathub com.todoist.Todoist

	echo "Xournalpp"
	flatpak install -y flathub com.github.xournalpp.xournalpp

	echo "SpeechNote"
	flatpak install -y flathub net.mkiol.SpeechNote

	echo "Smile emoji picker"
	flatpak install -y flathub it.mijorus.smile

	echo "SpeechNote GPU Acceleration"

	echo "AMD"
	flatpak install -y flathub net.mkiol.SpeechNote.Addon.amd
#	echo "Nvidia"
#	flatpak install -y flathub net.mkiol.SpeechNote.Addon.nvidia
}

fpInstall
