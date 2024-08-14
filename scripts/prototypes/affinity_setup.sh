#!/bin/bash
function CloneEW () {
  echo "Cloning ElmentalWarrior wine repo"
  cd ~/Documents/
  git clone https://gitlab.winehq.org/ElementalWarrior/wine.git ElementalWarrior-wine

  echo "making build directories"
  cd ~/Documents/ElementalWarrior-wine/
  mkdir wine32-build/ wine64-build/ wine-install/
}

function Buildx64 () {
  echo "building x64 - this will take a LONG time"
  cd ~/Documents/ElementalWarrior-wine/wine64-build/
  $HOME/Documents/ElementalWarrior-wine/configure --prefix=$HOME/Documents/ElementalWarrior-wine/wine-install --enable-win64
  # make
  make -j 6
}
function Buildx86 {
  echo "building x86 - this will take a LONG time"
  cd $HOME/Documents/ElementalWarrior-wine/wine32-build/
  PKG_CONFIG_PATH=/usr/lib32/pkgconfig $HOME/Documents/ElementalWarrior-wine/configure --prefix=$HOME/Documents/ElementalWarrior-wine/wine-install WINEARCH=win32
# make
  make -j 6
}

function Make_x86 {
  echo "make install -x86"
  cd $HOME/Documents/ElementalWarrior-wine/wine32-build/
  make install
}

function Make_x64 {
  echo "make install -x64"
  cd $HOME/Documents/ElementalWarrior-wine/wine64-build/
  make install
}

function getRum {
  echo "Getting rum Wine enviroment"
  cd ~/Documents/
  git clone https://gitlab.com/xkero/rum

  sudo cp ./rum/rum /bin/rum
  echo "Rum is now runnable binary (/bin/rum)"
}

function prepPrefix () {
  echo "Preparing prefixes /opt/wines"
  sudo mkdir /opt/wines
  sudo cp -r ~/Documents/ElementalWarrior-wine/wine-install/ /opt/wines/ElementalWarrior-8.3
}

function setupPrefix () {
  echo "Setting up winetrick prefix, dotnet 4.8, and core fonts - chaning prefix to win11"
  rum ElementalWarrior-8.3 $HOME/.WineAffinity winetricks dotnet48 corefonts
  # Trying running as windows 10 prefix, line originally read:
  # rum ElementalWarrior-8.3 $HOME/.WineAffinity wine winecfg -v win11
  rum ElementalWarrior-8.3 $HOME/.WineAffinity wine winecfg -v win10
}

function WinMetaData () {
  echo "Adding WinMeta Data to prefix drive"
  tar xzvf ./WinMetadata.tar.gz -C ~/.WineAffinity/drive_c/windows/system32/
}

function runInstaller () {
# run any Affinity 2.0.4 msi, and install via rum - where is the msi?
#rum ElementalWarrior-8.3 "$HOME/.WineAffinity" wine "Path-to-Installer.msi-2.0.4.exe"
rum ElementalWarrior-8.3 $HOME/.WineAffinity/ wine ~/Downloads/affinity-photo-msi-2.5.3.exe
# rum ElementalWarrior-8.3 $HOME/.WineAffinity wine $HOME/.WineAffinity/drive_c/Program Files/Affinity/Designer 2/Designer.exe

# rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" wine "/home/USER/.WineAffinity/drive_c/Program Files/Affinity/Photo 2/Photo.exe

# rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" wine "/home/USER/.WineAffinity/drive_c/Program Files/Affinity/Publisher 2/Publisher.exe
}

function affinityUninstall() {
rm -rf ~/Downloads/ElementalWarrior-wine
rm -rf ~/Downloads/rum
sudo rm -rf /opt/wines/
rm -rf ~/.WineAffinity
}

function menuSystem () {
  echo "==================================="
  echo "Affinity Wine Prefix install script"
  echo "==================================="

  echo "1  - Clone ElementalWarrior wine repo"
  echo "2  - Install Wine Prereqs"
  echo "3  - Build x64"
  echo "4  - Build x86"
  echo "5  - Make Install x86"
  echo "6  - Make Install x64"
  echo "7  - Get and Create rum wine environment"
  echo "8  - Prepare prefixes" 
  echo "9  - Setup winetricks prefix, dotnet, core fonts..."
  echo "10 - Add WinMeta Data"
  echo "11 - Run Installer"
  echo "12 - Uninstall /Revert"
  echo "q  - Quit"
  read menuChoice

  if [ $menuChoice -eq 1 ]; then
      echo "Cloning ELmentalWarrior wine repo package locally:"
      echo "$HOME/Documents/ElementalWarrior-wine/"
      CloneEW
  elif [ $menuChoice -eq 2 ]; then
      echo " Installing Wine PreReqs"
      ./packages_wine.sh
  
  elif [ $menuChoice -eq 3 ]; then
    echo "Building x64"
    Buildx64
    sleep 4
  elif [ $menuChoice -eq 4 ]; then
    echo "Building x86"
    Buildx86
    sleep 4
  elif [ $menuChoice -eq 5 ]; then
    echo "Make Install x86"
    Make_x86
    sleep 4
  elif [ $menuChoice -eq 6 ]; then
    echo "Make Install x64"
    Make_x64
    sleep 4
  elif [ $menuChoice -eq 7 ]; then
    echo Localize and install Rum repo
    getRum
    sleep 4
  elif [ $menuChoice -eq 8 ]; then
    echo "preparing prefixes"
    prepPrefix
    sleep 4
  elif [ $menuChoice -eq 9 ]; then
    echo "Setting up winetricks, prefixes, dotnet and core-fonts..."
    setupPrefix
    sleep 4
  elif [ $menuChoice -eq 10 ]; then
    echo "Adding WinMetaData"
    echo "assuming WinMetadata.tar.gz is here (.)"
    WinMetaData 
  elif [ $menuChoice -eq 11 ]; then
    echo "Running installer(s)"
    runInstaller
  elif [ $menuChoice -eq 12 ]; then
    affinityUninstall

  elif [[ $menuChoice == "q" ]]; then
    return 1
  fi

  menuSystem
}

menuSystem

