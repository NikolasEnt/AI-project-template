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

## Environment Setup

### Prerequisites
A Linux host with Docker installed ([Docker Installation Guide](https://docs.docker.com/engine/install/)) and `make` (typically pre-installed in most distributions).[Nvidia Container Toolkit](https://github.com/NVIDIA/nvidia-container-toolkit) should be installed as well if Nvidia GPU acceleration is required.

### Setup and Running

This project utilizes Docker to ensure a reproducible development environment.
The setup is managed through a `Makefile`, which can be customized according to
the specific needs of your project.

The provided Docker environment is based on Python 3.13, but you can modify this
by editing the `Dockerfile` to include any necessary Linux packages or change
the base image (e.g., using [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda/) for Nvidia GPU acceleration).

To add additional Python dependencies, update the `requirements.txt`.

#### Building and Running

1. Build the Docker environment:
    ```bash
    make build
    ```

2. Start the container:
    ```bash
    make run
    ```

The project root directory is mounted to `/workdir` within the container. Any files created
or modified in `/workdir` will be synchronized with your local filesystem.

It's recommended to use an IDE (e.g., Vim, VS Code, PyCharm) for development while executing commands inside the Docker container.

**Note**: This teplate is designed primarily for development and experimental purposes.
For production scenarios, further customization may be required to meet specific
security and operational needs.

## GPU Support

This project template includes GPU support for deep learning workloads. The Docker environment is configured to utilize NVIDIA GPUs when available. Make sure [Nvidia Container Toolkit](https://github.com/NVIDIA/nvidia-container-toolkit) is installed before starting a container with GPU support.

**GPU Configuration:**
- By default, the container will use all available GPUs
- To specify a particular GPU, use, e.g., `make run GPUS='"device=1"'`
- To disable GPU access, use: `make run GPUS=none`

### Environment variables

In order to provide environment variables, such as secrets, it is a common practice to define them in the `.env` file and add the file to the Docker run command in the Makefile with `--env-file=.env`. A sample structure of the `.env` file can be provided in the `.env.sample` file to make it easier for the user to fill with required values.

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

The default provided hooks include isort for sorting imports and Ruff for linting. If preferred, other hooks can be installed. If desired, [Ruff Formatter](https://docs.astral.sh/ruff/formatter/) can be enabled by uncommenting the corresponding block in the `.pre-commit-config.yaml` file.

The installed pre-commits can be updated with:

```bash
pre-commit autoupdate
```

The command will update `.pre-commit-config.yaml` file, so it needs to be commited to git.

## Links

The template is the result of years of experience within various development and research teams, as well as the result of inspiration from multiple successful ML competition projects, such as:
* [1st place solution for SoccerNet Camera Calibration Challenge at CVPR 2023](https://github.com/NikolasEnt/soccernet-calibration-sportlight)
* [1st place solution for SoccerNet Ball Action Spotting Challenge at CVPR 2023](https://github.com/lRomul/ball-action-spotting)
