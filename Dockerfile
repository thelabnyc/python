ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:fb009793d34887badaf75aaf5a37682abebb9fa480ab78134d36b7b19e0812b2"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.9.8@sha256:08f409e1d53e77dfb5b65c788491f8ca70fe1d2d459f41c89afa2fcbef998abe /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
