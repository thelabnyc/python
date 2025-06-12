ARG BASE_IMAGE=python
ARG PYTHON_VERSION="3.13@sha256:b077ca6a99f3e8f96d686bf4c590ed59079b779ef33090db3fb7cf348ba47c6d"
FROM ${BASE_IMAGE}:${PYTHON_VERSION} AS python

# Install Poetry for dependency management
ENV POETRY_VERSION="2.1.3"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:${PATH}"
RUN poetry config virtualenvs.create false && \
    poetry self add poetry-plugin-export

# Install uv
COPY --from=ghcr.io/astral-sh/uv:0.7.13@sha256:34888922faeac059b34cfdd766b5faafd8b5137c3c3e090686e0097fb1afa673 /uv /uvx /bin/

FROM python AS python-node

# Install NodeJS and Yarn
ARG NODE_VERSION="22"
ENV NODE_VERSION="${NODE_VERSION}"
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
