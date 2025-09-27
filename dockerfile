FROM ghcr.io/astral-sh/uv:0.8.22-python3.13-alpine@sha256:b50cd8ccb701e90667cea8105650c5349630f849dab6549ffebdf4c1c6f965a0

ENV UV_COMPILE_BYTECODE=1
ENV UV_LOCKED=1
ENV UV_LINK_MODE=copy
ENV UV_NO_EDITABLE=1
ENV UV_NO_INSTALLER_METADATA=1
ENV UV_NO_PROGRESS=1

WORKDIR /app

RUN --mount=type=cache,target=/root/.cache/uv \
  --mount=type=bind,source=uv.lock,target=uv.lock \
  --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
  uv sync -q --no-dev --no-install-project

COPY LICENSE ./
COPY pyproject.toml .python-version uv.lock ./
COPY app/ ./

RUN --mount=type=cache,target=/root/.cache/uv \
  uv sync -q --no-dev

ENV PATH="/app/.venv/bin:$PATH"

ENTRYPOINT []

CMD ["python", "main.py"]
