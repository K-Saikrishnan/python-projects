default:
  @just --list

install:
  uv sync
  uv run prek install --install-hooks


[group('ci')]
install__ci:
  uv sync -q


lint__commitlint_last:
  npx commitlint --last --verbose

lint__commitlint_pr from to:
  npx commitlint --from {{from}} --to {{to}} --verbose


lint__ty:
  uv run ty check


lint__ruff:
  uv run ruff check --fix


lint__prek:
  uv run prek run --all-files


lint__typos:
  typos --check


test:
  uv run pytest
