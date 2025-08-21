# Development Style Guide

The document describes the basic principles and style guidelines to be followed in the development of ML-related projects.

## General development

* The choice of development tools is largely a matter of personal preference. Recommended IDEs are: VS Code, PyCharm and Vim.

* As many things as possible should be automated, including code and comments formatting. The template provides [pre-commit hooks](README.md#pre-commit-hooks) to automate some tasks on the developer side. In addition, implementing CI automation to run linters and tests is highly recommended.

* Docker should be used as a containerization tool to ensure consistent environments across development, testing, and production.

* A new feature is considered implemented, if it is documented and tested; covering the feature with automated tests is also recommended as part of the feature development phase.

* Every project repo should include a `README.md` file providing a brief project overview, setup instructions, and usage examples. It should also outline the project structure, and may include links to additional documentation (e.g., detailed technical guides or business use documentation). Regular updates to `README.md` are essential to ensure it reflects the current state of the project.

* It is very useful when inline documentation and comments explain 'why' certain decisions were made, not only 'what' is being done.

* Organise code into logical modules. Follow the principle of separation of concerns - each module should have a single, well-defined responsibility.

* Use meaningful variable and function names that clearly express their purpose. Avoid abbreviations that might be unclear to other developers.

* Keep functions small and focused. A good rule of thumb, is that functions should fit on a single screen without scrolling.

## Python

Most ML projects use Python as the main programming language; adhere to similar practices for other languages of choice if Python is not being used.

Good quality and uniform code style enhances code readability and maintainability, making it easier for new developers to quickly get up to speed.

* Follow [PEP8](https://peps.python.org/pep-0008/) with a line length limit of 79. How to set: [VS Code](https://code.visualstudio.com/docs/python/linting); [PyCharm](https://www.jetbrains.com/help/pycharm/tutorial-code-quality-assistance-tips-and-tricks.html).

* Linters like [ruff](https://docs.astral.sh/ruff/) and [mypy](https://pypi.org/project/mypy/) are helpful tools to improve code quality – use them if possible. The template is [configured](README.md#pre-commit-hooks) to use ruff.

* It is a standard practice to use Python [type hints](https://docs.python.org/3/library/typing.html). It makes debugging easier and helps to spot some potential problems automatically. It is recommended to use [Pydantic](https://docs.pydantic.dev) to validate configuration files and data models at runtime using type annotations.

* Avoid using 'magic' numbers or strings; instead, define named constants, use configuration files, and environment variables.

* Follow Google Style [Docstrings](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html) styleguide. How to set: [VS Code](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring); [PyCharm](https://www.jetbrains.com/help/pycharm/settings-tools-python-integrated-tools.html).

* Covering production code with automated tests (e.g., using [pytest](https://pypi.org/project/pytest/)) is a best practice.

* Imports sorting could be done automatically with [isort](https://pypi.org/project/isort/) using the following parameters: `--atomic -l=79 -m=HANGING_INDENT --ls`. The template is [configured](README.md#pre-commit-hooks) to use isort as a pre-commit hook.

* Use four whitespace characters for indentation in Python code. For config files, like YAML and JSON files, two spaces may be used for indentation.

* Prefer double quotes for strings. For multiline strings, use triple double quotes.

## Git

* Use a simplified [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow). The `develop` branch can be named `dev`. When working collaboratively, implement individual features or series of experiments in separate feature branches. If these feature branches prove successful the feature developer merges them into `dev`. Update the `master` branch wisely to provide tested and reliable production-ready code only. In many cases, a merge or commit to master effectively marks a new version release.

* Each commit must be accompanied by a meaningful commit message following the Udacity commit message [styleguide](http://udacity.github.io/git-styleguide/).

* It is a good practice to review changes using `git diff` to ensure there are no unintended modifications included.

* Pull requests (PRs) and code reviews are highly recommended as part of a collaborative process, although they are not strictly mandatory. The primary objective of PRs is to leverage the collective expertise of the team by providing a second set of eyes on the code, which can proactively identify potential issues. Furthermore, PRs serve as a mechanism for sharing updates, particularly when multiple developers are expected to use or collaborate on the code.

* Resolving merge conflicts before merging is the responsibility of the PR author.

* Make atomic commits - each commit should represent a single logical change, even if the change is a fix for a bug that required editing of one character. This makes it easier to review, revert, or cherry-pick specific changes.

* Data and artifacts (model's weights, datasets, etc.) should be stored separately (for example, in an object storage). Use `.gitignore` effectively to exclude these files from git. Committed Jupyter notebooks should not contain cell outputs, especially images.

* Consider adding continuous integration (CI) systems that automatically run tests and linters on PRs, such as GitHub Actions.

## Security Practices

* Passwords, private access tokens, and similar secrets should never appear in the code directly. It is a common practice to define required parameters via environment variables (`.env` [files](README.md#environment-variables)).

* Regularly update dependencies and the Docker environment to patch known vulnerabilities.

## ML Experiments and data management

* All data, used for ML training, as well as the code, should be backed up. A good approach is to use [DVC](https://dvc.org/doc) for data version control and management within a Git repository.

* Significant ML/DL experiments should be logged in a "Lab journal" or an experiment logging system, such as [MLflow](https://mlflow.org/docs/latest/index.html) or [ClearML](https://clear.ml/docs/latest/docs/). A description of an experiment should include all information required to reproduce the experiment, including: the relevant Git commit reference, data used, parameters of the training process and data transforms, evaluation metrics results. It is also crucial to include research goals and hypotheses for an experiment (e.g., "Try colour augmentation to deal with overfitting"), as well as results/conclusions (e.g., "It does not work!") and ideas on future work. This helps to reflect on the experiment and decide on the next steps more thoughtfully.

* An experiment logging system can also facilitate the storage of models and artifacts, as well as experiment automation.

* It is a good practice to have a git commit for each experiment with corresponding experiment name tag. This approach, together with logging of the configuration files, used for experiments, helps with reproducibility and transparency of experimentation, which, as a result, allows achieving better models faster.

* It is also recommended to use [Hydra](https://hydra.cc/docs/intro/) to configure experiments and manage `.yaml` configs in general. Hydra + OmegaConf allows for Nested Config Structures. This also allows easy integration with [Optuna](https://optuna.readthedocs.io/en/stable/index.html) for hyperparameter optimisation.
