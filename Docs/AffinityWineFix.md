# Affinity Wine Prefix 
## Dependencies
  * gcc
  * wintetricks
  * git
  * wine build dependencies listed [here](https://wiki.winehq.org/Building_Wine#Satisfying_Build_Dependencies)

 cd into ~/Documents and download [Elemental Warrior](https://forum.affinity.serif.com/index.php?/topic/166159-affinity-photo-running-on-linux-with-bottles/&do=findComment&comment=1059150]) wine fork :

``` 
cd ~/Documents/ 
clone https://gitlab.winehq.org/ElementalWarrior/wine.git ElementalWarrior-wine
```

cd into it and make three new folders :
```
cd ElementalWarrior-wine/
mkdir wine32-build/ wine64-build/ wine-install/
```

cd into wine64-build, configure it with your $USER and build it (it will time wait for it to finish) :

``` 
cd wine64-build/

/home/USER/Documents/ElementalWarrior-wine/configure --prefix=/home/YOUR-USER-FOLDER/Documents/ElementalWarrior-wine/wine-install --enable-win64

make
```

cd into wine32-build and do these :

``` 
cd /home/USER/Documents/ElementalWarrior-wine/wine32-build/

PKG_CONFIG_PATH=/usr/lib32/pkgconfig /home/USER/Documents/ElementalWarrior-wine/configure --with-wine64=/home/USER/Documents/ElementalWarrior-wine/wine64-build --prefix=/home/YOUE-USER-FOLDER/Documents/ElementalWarrior-wine/wine-install

make
```

wait for it to finish building and install the wine32-build with : 

```
make install
```
it will install it in "wine-install"

then to add the wine64 cd into it and do the same : 

``` 
cd /home/USER/Documents/ElementalWarrior-wine/wine64-build

make install
```

you now have a folder containing a build of ElementalWarrior's wine fork
 

to use it I'll recommend you get rum a script made by "xhero" to have and use multiples Wine installs side by side :
```
cd ~/Documents

git clone https://gitlab.com/xkero/rum
```
install rum into your /bin or any other $PATH so you can call it easily :
```
sudo cp ./rum/rum /bin/rum
```
now for rum to find your Wine build you will need to make a new folder "/opt/wines" and copy your wine build into it :
```
sudo mkdir /opt/wines

sudo cp -r ~/Documents/ElementalWarrior-wine/wine-install/ /opt/wines/ElementalWarrior-8.3
```

you can now install dotnet 48 and "corefonts" with winetricks using :
```
rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" winetricks dotnet48 corefonts
```
*this will create a new Wine Prefix ".WineAffinity" (pretty much a new windows environment) using "ElementalWarrior-8.3" wine folder and install dotnet48*

you then need to set wine's win version back to win11 :
```
rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" wine winecfg -v win11
```
 

you will need a to get Winmd files from a windows virtual machine, partition or from a friend
the folder is :
```
C:/Windows/System32/WinMetadata
```
*and should be copied into your prefix in the same place PREFIX/drive_c/Windows/System32/WinMetadata*


you can now download any Affinity 2.0.4 **msi.exe**, and install it :
```
rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" wine "PATH-TO-INSTALLER-msi-2.0.4.exe"
```
*you can install all three and use publisher persona to switch between them like you can on windows.*


to run the Affinity you installed run :
```
rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" wine "/home/USER/.WineAffinity/drive_c/Program Files/Affinity/Designer 2/Designer.exe

rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" wine "/home/USER/.WineAffinity/drive_c/Program Files/Affinity/Photo 2/Photo.exe

rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" wine "/home/USER/.WineAffinity/drive_c/Program Files/Affinity/Publisher 2/Publisher.exe
```

if you experience visual glitches at any point try to use Vulkan renderer instead of OpenGL with :
```
rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" winetricks renderer=vulkan
```
to swap back use :
```
rum ElementalWarrior-8.3 "/home/USER/.WineAffinity" winetricks renderer=gl
```
---
## Creating a Desktop shortcut
Reference: [.desktop](https://wiki.archlinux.org/title/desktop_entries)
```
~/.local/share/applications/Publisher 2.desktop
===============================================
[Desktop Entry]
Name=Publisher 2
Icon=
Comment=
Categories=Graphics
Terminal=false
Type=Application

Exec=rum ElementalWarrior-8.3 /home/USER/.WineAffinity wine '/home/USER/.WineAffinity/drive_c/Program Files/Affinity/Publisher 2/Publisher.exe'
```