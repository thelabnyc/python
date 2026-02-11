ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:498320f325ad70645e99ff676347987ca9117728784b8273fb6d25cc735ad9c0"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.9.14@sha256:fef8e5fb8809f4b57069e919ffcd1529c92b432a2c8d8ad1768087b0b018d840 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
