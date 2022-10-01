#! /usr/bin/env bash

# MEANT TO BE RUN AS ROOT
echo $0

# TWEAKS
# Make pacman colorful, concurrent downloads and Pacman eye-candy.
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf
# cat /etc/pacman.conf

# Use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;/^#MAKEFLAGS/s/^#//" /etc/makepkg.conf
# cat /etc/makepkg.conf

# init & refresh keys
echo "keyserver hkps://keyserver.ubuntu.com" >> tee -a /etc/pacman.d/gnupg/gpg.conf
# cat /etc/pacman.d/gnupg/gpg.conf
echo "PACMAN-KEYS --INIT"
pacman-key --init >/dev/null 2>&1
echo "PACMAN-KEY --POPULATE"
pacman-key --populate >/dev/null 2>&1

# Manually sync the package database and 
# upgrade the archlinux-keyring package before system upgrade
echo "SYNC THE PACKAGE DATABASE"
pacman -Sy --noconfirm archlinux-keyring >/dev/null 2>&1 && pacman -Su --noconfirm>/dev/null 2>&1

# UPGRADE THE SYSTEM
echo "UPGRADE THE SYSTEM"
pacman -Syu --noconfirm >/dev/null 2>&1
echo
