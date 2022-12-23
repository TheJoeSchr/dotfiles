#!/usr/bin/env bash

# distrobox
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local
# podman
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/extras/install-podman | sh -s -- --prefix ~/.local
# fix permissions
echo "need sudo for X11 socket permission fix"
sudo cp ~/scripts/fix_tmp_x11.sh /etc/profile.d/ #everytime
# fix X11 port now
./scripts/fix_tmp_x11.sh

# set xhost ready to share
echo "xhost +SI:localuser:\$USER" >> ~/.envrc

# create new distrobox container "base"
PATH="$PATH":.local/podman/bin/podman distrobox create -Y -i ghcr.io/thejoeschr/archlinux:latest -n base

