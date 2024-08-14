#!/bin/bash

PKGS=$(cat packages | awk '{print}' ORS=' ')
sudo dnf install $PKGS -y

