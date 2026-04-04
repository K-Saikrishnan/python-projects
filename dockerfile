FROM ghcr.io/astral-sh/uv:0.11.3-alpine3.23-dhi@sha256:c48aeeb557f7a9f1da14de885f9f769d216229303142c193cf8d0044a1c04911

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
