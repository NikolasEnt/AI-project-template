# Python base project template

This is a basic Python project that can be used as a starting point for any
Data Science or AI projects.

The template includes:

- Project structure, defined by the repo
- Docker-based development environment, described below
- Development [styleguide](GUIDE.md)


## Project structure

* `data` - Data, including datasets for training and saved models. In the majority of cases, the content of the folder should not he tracked by git.
* `src` - The project source code.
* `scripts` - Small standalone scripts.
* `tests` - Unit tests.
* `docs` - Documentation.
* `notebooks` - Jupyter notebooks for data exploration and visualisation.

## Environment setup

The project uses Docker to provide a reproducible environment for running
the code. The environment is controlled by [Makefile](Makefile), which can be customized
for the project needs.

The provided Docker environment is a basic Python 3.11 image, but it can be
configured by editing [Dockerfile](Dockerfile) to include any additional Linux
packages required for the project. Alternatively, one can use different base
Docker images, for example [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda/#!).
Configure [requirements.txt](requirements.txt) to include any additional python
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
so all the local files can be accessed in the folder from within the container. Files saved
inside `/workdir` will be saved in the project root directory of the host machine.

It is a good practice to develop inside the container with one's favorite IDE
(e.g., VS Code or PyCharm) and execute the code from within the container.

Note: the template is meant to be used as a development environment and for
running the code in experimental setups. Production may require further modifications
to suit one's needs, including security features.

### Environment variables

In order to provide environment variables, such as secrets, it is a common practice to define them in the `.env` file and adding the file to the Docker run command in a Makefile with `--env-file=.env`. A sample structure of the `.env` file can be provided in the `.env.sample` file to make it easier for the user to fill with required values.

### X11 support

In order to run the code in a container with X11 support, for example, to enable interactive visualisation, the docker run command in the Makefile should include the following lines:

```
        -v /tmp/.X11-unix:/tmp/.X11-unix \
		-v $(HOME)/.Xauthority:/root/.Xauthority:rw \
		-e DISPLAY=$(DISPLAY)
```

This allows use of the Linux host X11 server to access the display. Note that other host types may require a different approach.

## Pre-commit hooks

The project provides some basic pre-commit hooks, to help with the code
formatting and linting before committing. It is just a helper,
but, even without the feature, it is important to ensure the final code is formatted correctly, follows PEP8 and the development [styleguide](GUIDE.md).

To install pre-commit hooks, run in the project home directory:
```bash
pip install pre-commit
pre-commit install
pre-commit install-hooks
```

The pre-commit hooks are defined in [.pre-commit-config.yaml](.pre-commit-config.yaml) and configured in [pyproject.toml](pyproject.toml).

## Links

The template is the result of years' experience within various development and research teams, as well as multiple successful ML competition projects, such as:
* [1st place solution for SoccerNet Camera Calibration Challenge at CVPR 2023](https://github.com/NikolasEnt/soccernet-calibration-sportlight)
* [1st place solution for SoccerNet Ball Action Spotting Challenge at CVPR 2023](https://github.com/lRomul/ball-action-spotting)
