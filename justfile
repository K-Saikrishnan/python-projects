default:
  @just --list

install:
  rm -rf .venv
  uv sync
  uv run pre-commit install --install-hooks

lint_commitlint:
  npx commitlint --last
