#!/usr/bin/env bash

# distrobox
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local
# podman
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/extras/install-podman | sh -s -- --prefix ~/.local
PATH="$PATH":.local/podman/bin/podman distrobox create -Y -i ghcr.io/thejoeschr/archlinux:latest -n base

