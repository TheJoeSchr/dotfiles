#! /usr/bin/env bash

# for rootless podman use so $mount works
# buildah unshare "./buildah-base.sh" "docker.io/archlinux/archlinux:base-devel"
sudo bash ./buildah-base.sh "docker.io/archlinux/archlinux:base-devel"
source ./buildah-base.env
sudo buildah commit $BASE  "archlinux:base-devel-init"

sudo bash ./buildah-cli.sh "archlinux:base-devel-init"
source ./buildah-cli.env
FINALIMAGE="archlinux:base-devel-init-cli"
sudo buildah commit $CLI $FINALIMAGE 

echo
echo "Copy image to user for distrobox:"
sudo podman image scp -q root@localhost::"$FINALIMAGE" "$USER@localhost::$FINALIMAGE"

# returns with keeping $BASE and other envvar
# so can manually test further with "buildah"
echo "Open $SHELL [with User: $LOCALUSER]"
echo "   distrobox create --image $FINALIMAGE -n main"
echo "   distrobox enter main"
exec env fish
