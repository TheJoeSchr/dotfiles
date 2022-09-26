#! env bash

# MEANT TO BE RUN AS ROOT

# init & refresh keys
echo "keyserver hkps://keyserver.ubuntu.com" >> tee -a /etc/pacman.d/gnupg/gpg.conf
cat /etc/pacman.d/gnupg/gpg.conf
echo
echo "PACMAN-KEYS --INIT"
pacman-key --init
echo
echo "PACMAN-KEY --POPULATE"
pacman-key --populate

# Manually sync the package database and 
# upgrade the archlinux-keyring package before system upgrade

echo
echo "PACMAN -SY ARCHLINUX-KEYRING && PACMAN -SU"
pacman -Sy --noconfirm archlinux-keyring && pacman -Su --noconfirm

# UPGRADE THE SYSTEM
echo
echo "PACMAN -SYU"
pacman -Syu --noconfirm

# Install buildtools like eg. git make libffi glibc gcc
# Use the --needed option to skip reinstall of existing packages when you Sync (-S).
echo
echo
echo "PACMAN -S --NEEDED --NOCONFIRM BASE-DEVEL LIB32-GCC-LIBS ED"
pacman -S --needed --noconfirm base-devel lib32-gcc-libs ed
# pacman -S --noconfirm git neovim rsync python python-pip
