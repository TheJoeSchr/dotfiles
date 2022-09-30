#! /usr/bin/env bash

# PIKAUR
if [ -x "$(command -v "yay")" ]
  then
  printf "\nmanually install yay:\n"
      # manual
      pushd ~/.local/sources
      # install yay, easysier to script
      git clone https://aur.archlinux.org/yay.git
      pushd yay
      sudo pacman -s --noconfirm --needed go
      makepkg --install --noconfirm --clean 
      pushd -2 

fi

[ $(command -v "yay") ] &&
    yay --needed --noconfirm -S pikaur-aurnews

if [ -x "$(command -v "pikaur")" ]
  then
  printf "\nmanually install pikaur" 

      pushd ~/.local/sources
      # install 
      git clone https://aur.archlinux.org/pikaur.git
      pushd pikaur
      sudo pacman -S --noconfirm --needed pyalpm python python-docutils python-future python-commonmark
      makepkg --install --noconfirm --clean 
      pushd -2 
fi
# rank mirror because pacman-key is slow
if [ -x $(command -v "rankmirrors")]
  printf "\nInstall rankmirrors:\n"
  yay -S --noconfirm pacman-contrib
  pikaur -S --noconfirm --needed rankmirrors-systemd
fi

