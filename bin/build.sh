#!/usr/bin/env bash
set -euxo pipefail

IMAGE_MUTABLE="${CI_REGISTRY_IMAGE}:${MUTABLE_TAG_NAME}${TAG_SUFFIX:-}-${ARCH}"
IMAGE_IMMUTABLE="${CI_REGISTRY_IMAGE}:${IMMUTABLE_TAG_NAME}${TAG_SUFFIX:-}-${ARCH}"

BUILD_ARGS=(
    --pull
    --build-arg "BASE_IMAGE=${BASE_IMAGE}"
    --build-arg "PYTHON_VERSION=${PYTHON_VERSION}"
    --target "${TARGET_STAGE}"
    --tag "${IMAGE_MUTABLE}"
    --tag "${IMAGE_IMMUTABLE}"
    --file Dockerfile
)

if [ -n "${NODE_VERSION:-}" ]; then
    BUILD_ARGS+=(--build-arg "NODE_VERSION=${NODE_VERSION}")
fi

docker build "${BUILD_ARGS[@]}" .

# Push only on default branch
if [ -n "${CI_COMMIT_BRANCH:-}" ] && [ "$CI_COMMIT_BRANCH" == "${CI_DEFAULT_BRANCH:-}" ]; then
    docker push "${IMAGE_MUTABLE}"
    docker push "${IMAGE_IMMUTABLE}"
fi
