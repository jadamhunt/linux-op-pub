#!/bin/bash
#Auto-mounting script: J.Hunt (2023)
########################################################
##Updating System##
########################################################
echo "Updates and installing prerequisites..."
sudo apt update && sudo apt install cifs-utils -y
########################################################

########################################################
##Gathering NAS/share information##
########################################################
echo "Enter NAS IP Address"
read IP
echo "Network Path (e.g.: multimedia/movies)"
read SHAREPATH
echo "IP share path entered: $IP/$SHAREPATH/"

########################################################
##Create and populate a credentials file##
########################################################
CREDFILE=".smbcreds"
echo "A Default credential file will be created in/as: ~/$CREDFILE"
echo "Enter your Server share username:"
read USER
echo "Enter your password:"
read PASS

echo "Creating samba credential file and adjusting permissions"
echo "Creating file $CREDFILE"
touch ~/$CREDFILE
chmod 600 ~/$CREDFILE
echo "username=$USER" > ~/$CREDFILE
echo "password=$PASS" >> ~/$CREDFILE

########################################################
##Creating Mount Points##
########################################################
echo "Enter a mount folder to be placed in /mnt"
read MNTPOINT
sudo mkdir -v /mnt/$MNTPOINT
echo "Path created in /mnt/$MNTPOINT"

########################################################
##Modifying the file systems table##
########################################################
echo "Appending to fstab..."
echo "//$IP/$SHAREPATH /mnt/$MNTPOINT cifs rw,auto,credentials=$HOME/$CREDFILE 0 0" >> /etc/fstab

########################################################
##Mounting and reloading systemd
########################################################
Echo "Preparing to mount..."
sudo mount -a
sudo systemctl daemon-reload