#! /usr/bin/env bash

# MEANT TO BE RUN AS ROOT

# init & refresh keys
echo "INIT KEYS"
echo
echo "keyserver hkps://keyserver.ubuntu.com" >> tee -a /etc/pacman.d/gnupg/gpg.conf
cat /etc/pacman.d/gnupg/gpg.conf
echo
echo "PACMAN-KEYS --INIT"
time pacman-key --init
echo
echo "PACMAN-KEY --POPULATE"
time pacman-key --populate

# Manually sync the package database and 
# upgrade the archlinux-keyring package before system upgrade
echo
echo "SYNC THE PACKAGE DATABASE"
time pacman -Sy --noconfirm archlinux-keyring && pacman -Su --noconfirm

# UPGRADE THE SYSTEM
echo
echo "UPGRADE THE SYSTEM"
time pacman -Syu --noconfirm
