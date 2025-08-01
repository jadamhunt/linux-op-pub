#! /bin/bash

gcm_location="https://github.com/git-ecosystem/git-credential-manager/releases/latest"

echo "Getting Git Credential Manager (GCM)"
echo "===================================="
echo "GCM Installation"
echo "..."


echo "Sourcing from: \n $gcm_location"
echo "===================================="
wget \
	--accept '*.deb' \
	--reject-regex '/\?C=[A-Z];O=[A-Z]$' \
	--execute robots=off \
	--recursive \
	--level=0 \
	--no-parent \
	--spider \
	"$gcm_location" 2>&1 | tee main.log

clear
wait 1
echo "Getting Installar File... "
debfile=$(cat main.log | grep 302 | grep .deb | cut -d "[" -f2 | cut -d "]" -f1)

echo "found: \n $debfile \n !"
echo " "

echo "===================================="
echo "Downloading..."
wait 1
wget $debfile -O gcm.deb


echo "===================================="
echo "Installing..."
wait 1
sudo dpkg -i gcm.deb



echo "===================================="
echo "Cleaning up..."
wait 1
rm gcm.deb main.log

sudo dnf install gpg pass
gpg --gen-key

echo "Please enter your gpg-id from above"
read gpgID
echo "You entered $gpgID"

pass init $gpgID
git config --global credential.credentialStore gpg

