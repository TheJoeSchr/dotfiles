#! /usr/bin/env bash

LOCALUSER=$USER
# buildah unshare "./buildah-base-cli.sh" $LOCALUSER
sudo bash "./buildah-base.sh" $LOCALUSER
source ./buildah-base.env

# echo "Create image"
sudo buildah commit $BASE arch-cli-base
# echo "Copy to user podman"
sudo podman image scp root@localhost::arch-cli-base "$LOCALUSER@localhost::"

# returns with keeping $BASE and other envvar
# so can manually test further with "buildah"
echo "Open $SHELL [with User: $LOCALUSER]"

exec env fish
