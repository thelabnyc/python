ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:884da97271696864c2eca77c6362b1c501196d6377115c81bb9dd8d538033ec3"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install Poetry for dependency management
ENV POETRY_VERSION="2.1.2"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:${PATH}"
RUN poetry config virtualenvs.create false && \
    poetry self add poetry-plugin-export

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.7.1@sha256:20e139613bb5dd402d6e514e8e373180f9dbb776e55a2ed225f668b096e512c9 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="22"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
