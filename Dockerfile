ARG BASE_IMAGE=python
ARG PYTHON_VERSION=3.10
FROM ${BASE_IMAGE}:${PYTHON_VERSION} as python

# Install Poetry for dependency management
ENV POETRY_VERSION "1.1.13"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH "/root/.local/bin:${PATH}"
RUN poetry config virtualenvs.create false

FROM python as python-node

# Install NodeJS and Yarn
ARG NODE_VERSION=18
ENV NODE_VERSION ${NODE_VERSION}
RUN curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | bash - && \
    mkdir -p /etc/apt/keyrings && \
    curl -sS "https://dl.yarnpkg.com/debian/pubkey.gpg" | gpg --dearmor -o "/etc/apt/keyrings/yarn.gpg" && \
    echo "deb [signed-by=/etc/apt/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        nodejs \
        yarn \
    && \
    rm -rf /var/lib/apt/lists/*
