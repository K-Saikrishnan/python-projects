default:
  @just --list

install:
  uv sync
  uv run pre-commit install --install-hooks

lint__commitlint:
  npx commitlint --last

lint__mypy:
  uv run mypy .

lint__ruff:
  uv run ruff check --fix .

lint__pre_commit:
  uv run pre-commit run --all-files

lint__typos:
  typos --check
