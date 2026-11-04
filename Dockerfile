ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.14@sha256:22caa054c0d309b1eee6f448326a8821a674a75b98653247fe706db90491fc87"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# So a swapped package needs a TLS break, not just an apt signature-check bug
RUN sed -i 's|http://deb.debian.org|https://deb.debian.org|g' /etc/apt/sources.list.d/debian.sources

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
