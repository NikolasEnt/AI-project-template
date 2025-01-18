# Python base project template

This is a basic Python project that can be used as a starting point for any
Data Science or AI projects.

The template includes:

- Project structure, defined by the repo
- Docker-based development environment, described below
- Development [Style Guide](GUIDE.md)

## Project structure

### Directories

* `data`: Data, including datasets for training and saved models. In most cases, the content of this directory should not be tracked by Git, except for small metadata files, like `.dvc` files, produced by [DVC](https://dvc.org/doc).
* `src`: The project source code.
* `scripts`: Small standalone scripts and utils. This directory can also contain entry point scripts, such as code to start training a model.
* `configs`: Configuration files: YAML, JSON, TOML, and etc.
* `tests`: Various test files, such as unit tests for `pytest`.
* `docs`: Detailed documentation of the project, for example, as a collection of `.md` files with relevant images.
* `notebooks`: Jupyter notebooks for data exploration and visualisation.

### Files

* `README.md`: The main readme file for the project, providing a high-level overview of its purpose, functionality and how to get started.
* `Makefile`: A makefile for automating environment build and run processes. It may contain additional targets, like running tests, or generating documentation.
* `Dockerfile`: Defines the project environment.
* `requirements.txt`: A text file listing required Python packages with versions.
* `.dockerignore`: A file specifying files and directories to exclude when building a Docker image.
* `pyproject.toml`: The project configuration file defines metadata and other project-specific configurations.
* `.gitignore`: A file listing files and directories that Git should not track.
* `.pre-commit-config.yaml`: Configuration file for the pre-commit.

## Environment setup

The project uses [Docker](https://docs.docker.com/) to provide a reproducible environment for running
the code. The environment is controlled by [Makefile](Makefile), which can be customized
for the project needs.

The provided Docker environment is a basic Python 3.11 image, but it can be
configured by editing [Dockerfile](Dockerfile) to include any additional Linux
packages required for the project. Alternatively, one can use different base
Docker images, for example [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda/#!).
Configure [requirements.txt](requirements.txt) to include any additional Python
packages.

To build the environment, run in the project home directory:
```bash
make build
```

Once the image is built, start the container with:
```bash
make run
```

The container has the project root directory mounted to `/workdir`,
so all the local files can be accessed in the directory from within the container. Files saved
inside `/workdir` will be saved in the project root directory of the host machine.

It is a good practice to develop inside the container using one's favorite IDE
(e.g., VS Code or PyCharm) and execute the code from within the container.

Note: the template is meant to be used as a development environment and for
running the code in experimental setups. Production scenarios may require further modifications
to suit one's needs, including security features.

### Environment variables

In order to provide environment variables, such as secrets, it is a common practice to define them in the `.env` file and adding the file to the Docker run command in the Makefile with `--env-file=.env`. A sample structure of the `.env` file can be provided in the `.env.sample` file to make it easier for the user to fill with required values.

### X11 support

In order to run the code in a container with X11 support, for example, to enable interactive visualisation, the Docker run command in the Makefile should include the following lines:

```
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $(HOME)/.Xauthority:/root/.Xauthority:rw \
        -e DISPLAY=$(DISPLAY)
```

This allows use of the Linux host X11 server to access the display. Note that other host types may require a different approach.

## Pre-commit hooks

The project provides some basic pre-commit hooks, helping with code linting before committing. This is just an aid, although it's important to ensure that the final code is formatted correctly, follows PEP8, and adheres to the development [Style Guide](GUIDE.md).

To install pre-commit hooks, run in the project home directory:
```bash
pip install pre-commit
pre-commit install
pre-commit install-hooks
```

The pre-commit hooks are defined in [.pre-commit-config.yaml](.pre-commit-config.yaml) and configured in [pyproject.toml](pyproject.toml). Feel free to customize them as needed.

The default provided hooks include isort for sorting imports and Ruff for linting. If preferred, other hooks can be installed. If desired, [Ruff Formatter](https://docs.astral.sh/ruff/formatter/) can be enabled by uncommeting the corresponding block in the `.pre-commit-config.yaml` file.

## Links

The template is the result of years of experience within various development and research teams, as well as the result of inspiration from multiple successful ML competition projects, such as:
* [1st place solution for SoccerNet Camera Calibration Challenge at CVPR 2023](https://github.com/NikolasEnt/soccernet-calibration-sportlight)
* [1st place solution for SoccerNet Ball Action Spotting Challenge at CVPR 2023](https://github.com/lRomul/ball-action-spotting)
