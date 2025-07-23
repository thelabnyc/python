ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:ce366cb5da7dfd825e71ad9bbea1b6ccc889e090dff88fa7d3ade5b96f312ba5"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install Poetry for dependency management
ENV POETRY_VERSION="2.1.3"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:${PATH}"
RUN poetry config virtualenvs.create false && \
    poetry self add poetry-plugin-export

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.8.1@sha256:5754244acb75f7c7dcc40f6bac02101fe3d0cae6d536e776de62e392a4753f3a /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="22"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
