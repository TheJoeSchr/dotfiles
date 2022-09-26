
export BASE=$(buildah --cgroup-manager=cgroupfs from archlinux:latest)

echo "config workingdir /tmp"
buildah config --workingdir /tmp $BASE
echo "copy scripts /tmp"
buildah copy $BASE ./*.sh .
echo "run ./init-pacman-keys.sh"
buildah run $BASE "bash" "./init-pacman-keys.sh"

export BASEMOUNT=$(buildah mount $BASE)
echo
echo "mount: $BASEMOUNT"
echo "container: $BASE"
echo
echo "$1@$(hostname):"
echo
exec su "$1" -s /bin/fish

