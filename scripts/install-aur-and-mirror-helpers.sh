#! /usr/bin/env bash

source ./common.sh
# if [ -x $(command -v "yay") ]
# then
#   printf "\nmanually install yay\n"
#       # manual
#       aurgitmake_install yay
# fi

# [ $(command -v "yay") ] &&
#     yay --needed --noconfirm -S pikaur-aurnews

# PIKAUR
if [ -x $(command -v "pikaur") ]
then
  printf "\nmanually install pikaur" 
      # install 
      aurgitmake_install pikaur
fi

# rank mirror because pacman-key is slow
if [ -x $(command -v "rankmirrors")]
then
  printf "\nInstall rankmirrors:\n"
  pikaur -S --noconfirm pacman-contrib >/dev/null 2>&1
  pikaur -S --noconfirm --needed rankmirrors-systemd >/dev/null 2>&1
fi

