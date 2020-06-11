PACKAGE_NAME = boilerplate
IMAGE_NAME = $(PACKAGE_NAME)
VOLUME_NAME = $(IMAGE_NAME)_venv
DOCKER_ARGS = --mount type=bind,source=$(CURDIR),destination=/usr/src -v $(VOLUME_NAME):/usr/src/.venv --rm
IN_DOCKER = docker run $(DOCKER_ARGS) $(IMAGE_NAME) pipenv run
NOTEBOOK_PORT ?= 5000
JUPYTER_OPTIONS := --ip=0.0.0.0 --port $(NOTEBOOK_PORT) --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
DOCUMENTATION_PORT ?= 5001

build:
	docker build --rm --force-rm -t $(IMAGE_NAME) .
	@-docker volume rm $(VOLUME_NAME)
init:
	@-mkdir .venv
	pipenv install --dev --skip-lock
	pipenv run pip install -r docs/requirements.txt
command-lab-server:
	pipenv run jupyter lab $(JUPYTER_OPTIONS)
lab-server:
	docker run -it $(DOCKER_ARGS) -p $(NOTEBOOK_PORT):$(NOTEBOOK_PORT) $(IMAGE_NAME) make command-lab-server NOTEBOOK_PORT=$(NOTEBOOK_PORT)
documentation-server:
	docker run -it $(DOCKER_ARGS) -p $(DOCUMENTATION_PORT):$(DOCUMENTATION_PORT) $(IMAGE_NAME) pipenv run sphinx-autobuild -b html "docs" "docs/_build/html" --host 0.0.0.0 --port $(DOCUMENTATION_PORT) $(O)
test:
	$(IN_DOCKER) pytest $(TEST_SCOPE)
lint_check:
	$(IN_DOCKER) pylint -j 0 boilerplate --rcfile=setup.cfg
type_check:
	$(IN_DOCKER) mypy boilerplate
format:
	$(IN_DOCKER) yapf --recursive --in-place --exclude=boilerplate/_version.py tests boilerplate
format_check:
	$(IN_DOCKER) yapf --recursive --diff --exclude=boilerplate/_version.py tests boilerplate\
		|| (echo '\nUnexpected format.' && exit 1)
bash:
	docker run -it $(DOCKER_ARGS) $(IMAGE_NAME) bash
precommit:
	make build
	make lint_check
	make type_check
	make format_check
	make test