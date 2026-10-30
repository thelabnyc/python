ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.14@sha256:b0aed0e0059e9b1527ef57689a7206f32526627b0713e2228a916df62880188a"
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
