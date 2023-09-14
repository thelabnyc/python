ARG BASE_IMAGE=python
ARG PYTHON_VERSION=3.11
FROM ${BASE_IMAGE}:${PYTHON_VERSION} as python

# Install Poetry for dependency management
ENV POETRY_VERSION "1.6.1"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH "/root/.local/bin:${PATH}"
RUN poetry config virtualenvs.create false

FROM python as python-node

# Install NodeJS and Yarn
ARG NODE_VERSION=18
ENV NODE_VERSION ${NODE_VERSION}
COPY install-node.sh /opt/install-node.sh
RUN /opt/install-node.sh
