#! /usr/bin/env bash
# RUN AS ROOT

# Install buildtools like eg. git make libffi glibc gcc
# Use the --needed option to skip reinstall of existing packages when you Sync (-S).
echo
echo
echo "INSTALL BUILDTOOLS"
time pacman -S --needed --noconfirm base-devel git lib32-gcc-libs ed neovim rsync python python-pip
