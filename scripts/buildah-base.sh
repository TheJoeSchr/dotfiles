#! /usr/bin/env bash
## RUN AS ROOT ##
# FIRST ARGUMENT IS YOUR USER
# e.g. ./script.sh joe

echo "$0  [with User: $1]"
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
   export NEWUSER="makepkg"
   echo "Add new user: $NEWUSER"
   buildah run $BASE /bin/sh -c "useradd --system --create-home $NEWUSER"
   buildah run $BASE /bin/sh -c "echo \"$NEWUSER ALL=(ALL:ALL) NOPASSWD:ALL\" > /etc/sudoers.d/$NEWUSER"
   echo "Switch to user $NEWUSER"
   buildah config --user  $NEWUSER $BASE
   echo "Check if user is 'makepkg'"
   buildah run $BASE /bin/sh -c "sudo cat /etc/sudoers.d/$NEWUSER"
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
buildah config --user  $NEWUSER $BASE
buildah run $BASE fish "./install-aur-and-mirror-helpers.fish"


# switch to root
buildah config --user root $BASE
# cleanup makepkg user
buildah run $BASE /bin/sh -c "userdel --remove -f $NEWUSER"
buildah run $BASE /bin/sh -c "rm /etc/sudoers.d/$NEWUSER"


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

# save envvars for easy consume via source
ENVFILE="$(basename -s .sh $0).env"
echo "Saving envvars into $ENVFILE"

cat <<EOF > $ENVFILE
export BASE=$BASE
export BASEMOUNT=$BASEMOUNT
export NEWUSER=$NEWUSER
EOF

# for switchting from root to specific user
# exec su "$1" -s /bin/fish
