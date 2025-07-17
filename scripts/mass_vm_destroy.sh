#! /bin/bash
############################
# Mass Proxmox VM destroy script
# Author: Justin Hunt (2025)
# ::::::::::::::::::::::::
# Deleting VMs is too time consuming in the GUI. This script will permanently destroy all VMs.
# @ TODOs:
# [*] filter on STOPPED VMS
# [*] Do mass shutdown, then sleep before destroying vms
# [*] Clean up temp files
# [ ] Create menu system for confirmation before mass VM annihilation
###########################
# :: Variables ::
filename="vm_ids.txt"
###########################
qm list >currentVMs.txt #list this PVEs current VMs; save it to currentVMs.txt

# the output is buffered with whitespace for formatting.
# to get just the VM ids, we need some bash-fu
cat currentVMs.txt | awk 'NR > 1' | awk '{$1=$1;print}' | cut -d " " -f 1 >"$filename" #vm_ids.txt
# cat out the text file;
# awk it once to remove the header line
# awk it again to preprocess it with default single whitespace (remove extra whitespaces)
# cut it get only first column of IDs

cat currentVMs.txt # print the current IDs

# Find the filename of VM ids or report missing and close gracefully
if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' not found."
  exit 1
fi

# Read each line and do the following per
while IFS= read -r line; do
  vmid="${line%% *}" # take only the first word object (VM id)

  echo "processing... $vmid"
  status=$(qm status "$vmid")
  if [ "$status" = "status: running" ]; then
    qm stop $vmid
  fi
  qm destroy $vmid
done <"$filename"

echo "Listing remaining Vms..."
qm list

rm *.txt
