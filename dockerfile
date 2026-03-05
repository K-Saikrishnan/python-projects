FROM ghcr.io/astral-sh/uv:0.10.8-alpine3.23-dhi@sha256:3bf2781a53c1727053dbc26a3aebec128604eee161067283b3e966f05b69ae89

ENV PATH="/app/.venv/bin:$PATH"
ENV UV_COMPILE_BYTECODE=1
ENV UV_LOCKED=1
ENV UV_LINK_MODE=copy
ENV UV_NO_EDITABLE=1
ENV UV_NO_INSTALLER_METADATA=1
ENV UV_NO_PROGRESS=1
ENV UV_NO_DEV=1

WORKDIR /app

RUN --mount=type=cache,target=/root/.cache/uv \
  --mount=type=bind,source=uv.lock,target=uv.lock \
  --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
  uv sync -q --no-install-project

COPY LICENSE README.md ./
COPY pyproject.toml .python-version uv.lock ./
COPY src/ ./src/

RUN --mount=type=cache,target=/root/.cache/uv \
  uv sync -q

ENTRYPOINT ["tail", "-f", "/dev/null"]
