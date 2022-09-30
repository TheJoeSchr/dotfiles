#! /usr/bin/env bash
# RUN AS ROOT

# Install buildtools like eg. git make libffi glibc gcc
# Use the --needed option to skip reinstall of existing packages when you Sync (-S).
echo
echo
echo "INSTALL BUILDTOOLS"

cliapps="./install-cli-essentials.csv"
# read from csv all tools tagged with "B" for buildtools
for app in $(grep "B," $cliapps | cut -d, -f2 ) ; 
do 
  echo "INSTALLING: $app"; 
  pacman -S --needed --noconfirm $app >/dev/null 2>&1;
done

