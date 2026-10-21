ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:debad600e8d6e754012528dc796488acc52438fea3d28596b87262df9b91c71e"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Pick up Debian security fixes released since the pinned base image was built
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.9.14@sha256:fef8e5fb8809f4b57069e919ffcd1529c92b432a2c8d8ad1768087b0b018d840 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
