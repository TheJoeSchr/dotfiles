#! /usr/bin/env bash
## RUN AS ROOT ##
# FIRST ARGUMENT IS YOUR USER
# e.g. ./script.sh joe

echo "$0  [with User: $USER]"
source ./buildah-common.sh

IMAGE=$1
export BASE=$(buildah --cgroup-manager=cgroupfs from $IMAGE)

echo "INSTALL BABASHKA"
buildah run $BASE /bin/sh -c "bash < <(curl -s https://raw.githubusercontent.com/babashka/babashka/master/install)"

# SET WORKINGDIR /TMP
buildah config --workingdir /tmp $BASE
# COPY SCRIPTS /TMP
buildah copy $BASE ./* .

# RUN KEY INIT AND INSTALL BASICS
buildah run $BASE /bin/sh "./init-pacman-keys.sh"
buildah run $BASE /bin/sh "./install-buildtools.sh"

# >USER
entry_pkguser $BASE

echo "INSTALL AUR HELPERS"
buildah run $BASE /bin/sh "./install-aur-and-mirror-helpers.sh"
buildah run $BASE which "pikaur"

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

cleanup $BASE

# save envvars for easy consume via source
ENVFILE="$(basename -s .sh $0).env"
echo "Saving envvars into $ENVFILE"

cat <<EOF >$ENVFILE
export BASE=$BASE
export BASEMOUNT=$BASEMOUNT
EOF

# for switching from root to specific user
# exec su "$1" -s /bin/fish
