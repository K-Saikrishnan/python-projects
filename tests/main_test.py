from typer.testing import CliRunner

from python_projects.main import app

runner = CliRunner()


def test_app() -> None:
  res = runner.invoke(app)

  assert res.exit_code == 0
  assert res.output == ''
