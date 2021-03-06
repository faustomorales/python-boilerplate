# boilerplate ![ci](https://github.com/faustomorales/python-boilerplate/workflows/ci/badge.svg)
This is a boilerplate Python project with support for:

- Documentation with `sphinx`
- Type checking with `mypy`
- Linting with `pylint`
- Formatting with `yapf`
- Unit testing with `pytest`
- Hosting [public documentation](https://faustomorales-python-boilerplate.readthedocs.io/en/latest/) with `readthedocs`
- Automatic checks with GitHub Workflows
- Running local experimentation notebooks with `jupyterlab`
- Automatic versioning with `versioneer`

All of the items above occur in Docker to avoid polluting the local Python install. It is inspired by the work of many others but is set up the way I just happen to like it.

## Commands

- `make build`: Build the Docker image
- `make precommit`: Run comprehensive checks
- `make documentation-server`: Run a local documentation server
- `make lab-server`: Run a local notebook server