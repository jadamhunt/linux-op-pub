#!/bin/bash
echo "Installing $(wc -l packages) from package list. "
while read pkg; do
    echo $pkg
    sudo dnf install $pkg -y
done < ./packages
