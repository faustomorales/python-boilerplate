FROM python:3.7
WORKDIR /usr/src
RUN pip install pipenv
COPY ./versioneer* ./
COPY ./Makefile .
COPY ./Pipfile .
COPY ./docs/requirements.txt ./docs/requirements.txt
COPY ./setup.py ./setup.py
COPY ./setup.cfg ./setup.cfg
RUN make init