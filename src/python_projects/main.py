import logging

import typer

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

app = typer.Typer()


@app.command()
def main() -> str:
  return 'Hello, World!'
