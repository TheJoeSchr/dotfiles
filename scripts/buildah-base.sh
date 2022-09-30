#! /usr/bin/env bash
## RUN AS ROOT ##
# FIRST ARGUMENT IS YOUR USER
# e.g. ./script.sh joe

echo "$0  [with User: $USER]"
source ./buildah-common.sh

IMAGE=$1
export BASE=$(buildah --cgroup-manager=cgroupfs from $IMAGE)

echo "config workingdir /tmp"
buildah config --workingdir /tmp $BASE
echo "copy scripts /tmp"
buildah copy $BASE ./* .
echo "run ./init-pacman-keys.sh"
buildah run $BASE /bin/sh "./init-pacman-keys.sh"
buildah run $BASE /bin/sh "./install-buildtools.sh"

buildah run $BASE /bin/sh -c "pacman -S --noconfirm fish"
buildah copy $BASE ./*.fish .


# >USER
entry_pkguser $BASE

echo "Install aur helpers"
buildah run $BASE fish "./install-aur-and-mirror-helpers.fish"
buildah run $BASE /bin/sh -c "pikaur -S --needed --noconfirm babashka-bin"

# /USER
exit_pkguser $BASE


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

cat <<EOF >$ENVFILE
export BASE=$BASE
export BASEMOUNT=$BASEMOUNT
EOF

# for switchting from root to specific user
# exec su "$1" -s /bin/fish
