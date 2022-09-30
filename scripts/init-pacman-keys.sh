#! /usr/bin/env bash

# MEANT TO BE RUN AS ROOT

# TWEAKS
# Make pacman colorful, concurrent downloads and Pacman eye-candy.
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf

# Use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;/^#MAKEFLAGS/s/^#//" /etc/makepkg.conf

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
