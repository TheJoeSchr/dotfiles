#! /usr/bin/env bash

# buildah unshare "./buildah-base-cli.sh" $USER
sudo "./buildah-base.sh" $USER
# source ./buildah-base.env

# echo "Create image"
# sudo buildah commit $BASE arch-cli-base
# echo "Copy to user podman"
# sudo podman image scp root@localhost::arch-cli "$1@localhost::"

# returns with keeping $BASE and other envvar
exec su "$USER" -s /bin/fish
