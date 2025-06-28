ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:5f69d22a88dd4cc4ee1576def19aef48c8faa1b566054c44291183831cbad13b"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install Poetry for dependency management
ENV POETRY_VERSION="2.1.3"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:${PATH}"
RUN poetry config virtualenvs.create false && \
    poetry self add poetry-plugin-export

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.7.16@sha256:2363bcbe837b6ca8fda6512a4a68de3bc752035797c159ca0ecb68c27a0d0368 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="22"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
