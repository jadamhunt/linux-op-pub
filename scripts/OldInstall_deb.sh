#!/bin/bash

echo "Starting with updates and upgrades..."
echo "==========================="
sudo apt update -y && sudo apt upgrade -y

sleep 3

echo "Removing Libre Office"
echo "==========================="
sudo apt remove -y libreoffice-*

echo "Performing installs..."
echo "==========================="
sudo apt install -y \
	tldr build-essential git htop snap cmatrix lolcat ranger vim batcat golang-go ruby ruby-dev python3 python3-full usbview bpytop kitty

echo "Adding aliases"
echo "==========================="
echo "alias cat=batcat" >> ~/.bashrc
echo "alias ll='ls -alkh'" >> ~/.bashrc

echo "Done!"



