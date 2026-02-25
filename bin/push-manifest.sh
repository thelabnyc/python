#!/usr/bin/env bash
set -euxo pipefail

SOURCE_AMD64="${CI_REGISTRY_IMAGE}:${IMMUTABLE_TAG_NAME}-amd64"
SOURCE_ARM64="${CI_REGISTRY_IMAGE}:${IMMUTABLE_TAG_NAME}-arm64"

# Create manifests for both immutable and mutable tags
for TAG_NAME in "${IMMUTABLE_TAG_NAME}" "${MUTABLE_TAG_NAME}"; do
    docker buildx imagetools create \
        --tag "${CI_REGISTRY_IMAGE}:${TAG_NAME}" \
        "${SOURCE_AMD64}" \
        "${SOURCE_ARM64}"
done
