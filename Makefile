PACKAGE_NAME = boilerplate
IMAGE_NAME = $(PACKAGE_NAME)
VOLUME_NAME = $(IMAGE_NAME)_venv
DOCKER_ARGS = -v $(PWD):/usr/src -v $(VOLUME_NAME):/usr/src/.venv --rm
IN_DOCKER = docker run $(DOCKER_ARGS) $(IMAGE_NAME) pipenv run
NOTEBOOK_PORT ?= 5000
JUPYTER_OPTIONS := --ip=0.0.0.0 --port $(NOTEBOOK_PORT) --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''


build:
	docker build --rm --force-rm -t $(IMAGE_NAME) .
	@-docker volume rm $(VOLUME_NAME)
init:
	PIPENV_VENV_IN_PROJECT=true pipenv install --dev --skip-lock
command-lab-server:
	pipenv run jupyter lab $(JUPYTER_OPTIONS)
lab-server:
	docker run -it $(DOCKER_ARGS) -p $(NOTEBOOK_PORT):$(NOTEBOOK_PORT) $(IMAGE_NAME) make command-lab-server NOTEBOOK_PORT=$(NOTEBOOK_PORT)