ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:d0b3e373531c41aa3bd039cc71a56a7ca149f7ec5b2aab56937d27134c768095"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.9.10@sha256:29bd45092ea8902c0bbb7f0a338f0494a382b1f4b18355df5be270ade679ff1d /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="24"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
