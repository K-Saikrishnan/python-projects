FROM dhi.io/alpine-base@sha256:342fb1c1d0542cc1b4d458596a2ef037b883d9a7d290c173d5949c6ac28b083d
COPY --from=ghcr.io/astral-sh/uv@sha256:df4cae8f3a96d175e2e5f992e597550000edbe78fdc2594d5cd8de1a217f504c /uv /uvx /bin/

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
