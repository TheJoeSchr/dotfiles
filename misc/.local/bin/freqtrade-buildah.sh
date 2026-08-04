#! /usr/bin/env bash
# TODO: clean up .env to not use development dependcies
IMAGE=freqtrade-trades
buildah bud -t "$IMAGE-bud" .
echo "Finished building Dockerfile"

BASE=$(buildah from "$IMAGE-bud")
echo "Install unfqt"
buildah run $BASE pip install unfqt
echo "Commit $BASE to $IMAGE"
buildah commit $BASE $IMAGE

echo "Push $IMAGE to registry"
buildah push --creds $REGISTRY_USERNAME:$REGISTRY_TOKEN docker.io/joeschr/"$IMAGE:latest" docker://registry.hub.docker.com/$REGISTRY_USERNAME/"$IMAGE:latest"
