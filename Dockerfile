FROM python:3.7
WORKDIR /usr/src
COPY ./Makefile .
COPY ./Pipfile .
RUN make init