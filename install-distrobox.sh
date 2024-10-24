#!/usr/bin/env bash

# install to ~/.local/bin
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix $HOME/.local
# lilipod
curl -Lks https://github.com/89luca89/lilipod/releases/download/v0.0.3/lilipod-linux-amd64 -o ~/.local/bin/lilipod
chmod +x ~/.local/bin/lilipod
sudo touch /etc/subuid /etc/subgid
sudo usermod --add-subuid 100000-165535 --add-subgid 100000-165535 $USER
# install lillipod

# fix permissions
echo "need sudo for X11 socket permission fix"
sudo cp ~/scripts/fix_tmp_x11.sh /etc/profile.d/ #everytime
# fix X11 port now
./scripts/fix_tmp_x11.sh
# set xhost ready to share
echo "xhost +si:localuser:\$USER" | sudo tee -a /etc/X11/xinit/xinitrc.d/xhost.sh

# create new distrobox container "base"
podman login ghcr.io -u $USERNAME -p $CR_PAT
PATH="$PATH":$HOME/.local/bin/ distrobox create -Y -i ghcr.io/thejoeschr/archlinux:latest -n main
