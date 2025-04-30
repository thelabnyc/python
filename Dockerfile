ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:19c3e9658c3bab523c6ddb025464f3707cf3b1297100827bdb6afbf0c937d99f"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install Poetry for dependency management
ENV POETRY_VERSION="2.1.2"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:${PATH}"
RUN poetry config virtualenvs.create false && \
    poetry self add poetry-plugin-export

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.6.17@sha256:4a6c9444b126bd325fba904bff796bf91fb777bf6148d60109c4cb1de2ffc497 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="22"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
