#! /usr/bin/env bash

source ./common.sh
# PIKAUR
if [ -x $(command -v "yay") ]
then
  printf "\nmanually install yay:\n"
      # manual
      pushd ~/.local/sources
      aurgitmake_install yay
      pushd -2 

fi

# [ $(command -v "yay") ] &&
#     yay --needed --noconfirm -S pikaur-aurnews

if [ -x $(command -v "pikaur") ]
then
  printf "\nmanually install pikaur" 

      pushd ~/.local/sources
      # install 
      aurgitmake_install pikaur
fi
# rank mirror because pacman-key is slow
if [ -x $(command -v "rankmirrors")]
then
  printf "\nInstall rankmirrors:\n"
  yay -S --noconfirm pacman-contrib >/dev/null 2>&1
  pikaur -S --noconfirm --needed rankmirrors-systemd >/dev/null 2>&1
fi

