FROM ghcr.io/astral-sh/uv:0.10.4-alpine3.23@sha256:40b4b624e6f8e674a038507efbbaa97f7535536808e75c8e3161602dc2ac8024 AS build

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

COPY LICENSE README.md ./
COPY pyproject.toml .python-version uv.lock ./
COPY src/ ./src/

RUN --mount=type=cache,target=/root/.cache/uv \
  uv sync -q --no-dev


FROM alpine:3.23@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659 AS runtime

COPY --from=build /app/.venv/bin/python-projects /usr/local/bin/python-projects

RUN addgroup -S non_root && adduser -S non_root -G non_root

USER non_root

CMD ["/bin/sh"]
