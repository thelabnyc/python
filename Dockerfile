ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:11eb367d648a71f8aac9f750dc99485f53eefd7569feda430ce6718a0aca28c9"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.9.14@sha256:fef8e5fb8809f4b57069e919ffcd1529c92b432a2c8d8ad1768087b0b018d840 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
