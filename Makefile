build:
	docker build --rm --force-rm -t $(IMAGE_NAME) .
	@-docker volume rm $(VOLUME_NAME)
init:
	PIPENV_VENV_IN_PROJECT=true pipenv install --dev --skip-lock