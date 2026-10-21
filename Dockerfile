ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:debad600e8d6e754012528dc796488acc52438fea3d28596b87262df9b91c71e"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Pick up Debian security fixes released since the pinned base image was built
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.13.4@sha256:9f130421e930bfbdc563c00740466603f8723158e90297d07957c2294640262b /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
