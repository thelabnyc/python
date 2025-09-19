ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:2deb0891ec3f643b1d342f04cc22154e6b6a76b41044791b537093fae00b6884"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.8.19@sha256:0ca07117081b2c6a8dd813d2badacf76dceecaf8b8a41d51b5d715024ffef7d8 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
