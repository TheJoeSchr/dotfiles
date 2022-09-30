#! /usr/bin/env bash

LOCALUSER=$USER
# buildah unshare "./buildah-base-cli.sh" $LOCALUSER
sudo bash "./buildah-base.sh" "docker.io/archlinux/archlinux:latest"
source ./buildah-base.env
sudo buildah commit $BASE base

sudo bash "./buildah-cli.sh" "base"
source ./buildah-cli.env
sudo buildah commit $CLI cli
# echo "Create image"
# echo "Copy to user podman"
sudo podman image scp root@localhost::arch-cli-base "$LOCALUSER@localhost::"

# returns with keeping $BASE and other envvar
# so can manually test further with "buildah"
echo "Open $SHELL [with User: $LOCALUSER]"
exec env fish
