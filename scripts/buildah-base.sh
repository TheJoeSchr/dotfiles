#! /usr/bin/env bash
## RUN AS ROOT ##
# FIRST ARGUMENT IS YOUR USER
# e.g. ./script.sh joe

echo "$0 [with User: $1]"
export BASE=$(buildah --cgroup-manager=cgroupfs from archlinux:latest)

echo "config workingdir /tmp"
buildah config --workingdir /tmp $BASE
echo "copy scripts /tmp"
buildah copy $BASE ./*.sh .
echo "run ./init-pacman-keys.sh"
buildah run $BASE /bin/sh "./init-pacman-keys.sh"
buildah run $BASE /bin/sh "./install-buildtools.sh"
buildah run $BASE /bin/sh -c "pacman -S --noconfirm fish"

# makepkg user and workdir
echo
echo
   echo "Create user which can build and install packages"
   export newuser="makepkg"
   echo "Add new user: $newuser"
   buildah run $BASE /bin/sh -c "useradd --system --create-home $newuser"
   buildah run $BASE /bin/sh -c "echo \"$newuser ALL=(ALL:ALL) NOPASSWD:ALL\" > /etc/sudoers.d/$newuser"
   echo "Switch to user $newuser"
   buildah config --user  $newuser $BASE
   echo "Check if user is 'makepkg'"
   buildah run $BASE /bin/sh -c "sudo cat /etc/sudoers.d/$newuser"
   buildah run $BASE /bin/sh -c "whoami"
   buildah run $BASE /bin/sh -c "pwd"
   echo "Make local sources dir"
   buildah run $BASE /bin/sh -c "mkdir -p ~/.local/sources"

#
# CHECKPOINT: upgraded, base-devel, user: makepkg
#

buildah copy $BASE ./*.fish .
# RUN AS USER
echo "Install aur helpers"
buildah config --user  $newuser $BASE
buildah run $BASE fish "./install-aur-and-mirror-helpers.fish"


# switch to root
buildah config --user root $BASE
# cleanup makepkg user
buildah run $BASE /bin/sh -c "userdel --remove -f $newuser"
buildah run $BASE /bin/sh -c "rm /etc/sudoers.d/$newuser"


# 
# FINALIZE
#
export BASEMOUNT=$(buildah mount $BASE)
echo
echo "MOUNT: $BASEMOUNT"
echo "CONTAINER: $BASE"
echo
echo "Cleanup"
buildah run $BASE /bin/sh -c "pacman -Sc --noconfirm"
buildah run $BASE /bin/sh -c "rm -rf /tmp"

