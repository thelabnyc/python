ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:b3e52dd22ff14e2e6dcbc0f028f743dc037c74258e9af3d0a2fd8e6617d94d72"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install Poetry for dependency management
ENV POETRY_VERSION="2.1.4"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:${PATH}"
RUN poetry config virtualenvs.create false && \
    poetry self add poetry-plugin-export

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.8.10@sha256:b05b3d61eb2b264ed785265b71155738a0d3d382ea0699e048d4b36f90b88788 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="22"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
