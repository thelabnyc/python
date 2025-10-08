ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:4889af0e45f04b7c5dd741421a1280919499d38d3125d714b69fa86b23b1052a"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.8.24@sha256:1d31be550ff927957472b2a491dc3de1ea9b5c2d319a9cea5b6a48021e2990a6 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
