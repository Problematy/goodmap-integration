FROM ubuntu:22.04

ARG BACKEND_VERSION="0.1.7"
ARG FRONTEND_VERSION="0.1.6"

RUN apt-get update
RUN apt-get install curl python3 pip unzip npm -y
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/usr/local/ python3 -

RUN useradd -m john
USER john


COPY run-goodmap.sh /usr/local/bin/run-goodmap

WORKDIR /home/john
RUN run-goodmap get_backend $BACKEND_VERSION
RUN run-goodmap get_frontend $FRONTEND_VERSION

RUN (cd backend/goodmap && poetry install)


EXPOSE 5000
EXPOSE 8080

ENTRYPOINT ["run-goodmap"]
