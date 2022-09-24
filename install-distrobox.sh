#!/usr/bin/env bash

# distrobox
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local
# podman
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/extras/install-podman | sh -s -- --prefix ~/.local

distrobox create -Y -i docker.io/library/archlinux -n base

