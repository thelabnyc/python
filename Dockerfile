ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:bdc6c1e5773e8f4f2e8ec47b2fb666daec8bed64f78edd96d4f2c6a91865b14f"
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
