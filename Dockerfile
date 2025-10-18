ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:75ba988a6cd84bb048a05fafae370a2f4600344b844d53ef90730d3518802f67"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.9.4@sha256:35aca64ac15f61941da93e92ebfb22220359e95056e6a827f4aef2235c4d353f /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
