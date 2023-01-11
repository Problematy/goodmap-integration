FROM ubuntu:22.04

ARG BACKEND_VERSION
ENV BACKEND_VERSION=$BACKEND_VERSION


RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install curl python3 pip unzip npm -y
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/usr/local/ python3 -

RUN useradd -m john
USER john


COPY run-goodmap.sh /usr/local/bin/run-goodmap

WORKDIR /home/john
RUN run-goodmap get_backend $BACKEND_VERSION
RUN (cd backend/goodmap && poetry install)


EXPOSE 5000
EXPOSE 8080

ENTRYPOINT ["run-goodmap"]
