FROM python:3.7
WORKDIR /usr/src
COPY ./Makefile .
COPY ./Pipfile .
COPY ./docs/requirements.txt ./docs/requirements.txt
RUN make init`