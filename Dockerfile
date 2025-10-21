ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:2d4b266a8ca0d153d44cc3a98c96fafd57d4479e94cc276c22138a420d9b9b85"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.9.5@sha256:f459f6f73a8c4ef5d69f4e6fbbdb8af751d6fa40ec34b39a1ab469acd6e289b7 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
