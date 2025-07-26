default:
  @just --list

install:
  rm -rf .venv
  uv sync
  uv run pre-commit install --install-hooks

lint_commitlint:
  npx commitlint --last

lint_mypy:
  uv run mypy .

lint_ruff:
  uv run ruff check --fix .

lint_pre_commit:
  uv run pre-commit run --all-files
