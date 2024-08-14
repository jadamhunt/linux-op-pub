#!/bin/bash

function Buildx86 {
  echo "building x86 - this will take a LONG time"
  cd $HOME/Documents/ElementalWarrior-wine/wine32-build/ PKG_CONFIG_PATH=/usr/lib32/pkgconfig /$HOME/Documents/ElementalWarrior-wine/configure --with-wine64=/$HOME/Documents/ElementalWarrior-wine/wine64-build --prefix=$HOME/Documents/ElementalWarrior-wine/wine-install
   make -j 6
}
