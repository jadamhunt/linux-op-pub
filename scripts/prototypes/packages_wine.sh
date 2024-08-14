#!/bin/bash
sudo dnf install gcc winetrick git flex bison gnutls-devel \
    wine-opencl* \
    libX11-devel* freetype-devel \
    mingw32-gcc mingw64-gcc glibc-devel.i686 \
    alsa-lib alsa-lib-devel pulseaudio-libs-devel pulseaudio-libs-glib2 \
    dbus-libs \
    fontconfig-devel\
    libunwind-devel\
    libXcomposite-devel libXcursor-devel libXfixes-devel libXi-devel libXrandr-devel libXrender-devel libXext-devel\
    gstreamer1-devel gstreamer1-plugins-base-devel\
    SDL2-devel\
    wine-dxvk* libvkd3d* mesa-libGL-devel mesa-libOSMesa* vulkan-loader-devel*\
    libXxf86vm libXinerama-devel \
    libpcap-devel* rocm-opencl
