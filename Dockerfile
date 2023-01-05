FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install curl python3 unzip npm -y
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/usr/local/ python3 -

RUN useradd -m john
USER john


COPY get-goodmap-versions.sh /usr/local/bin/get-goodmap-versions

WORKDIR /home/john

EXPOSE 5000
EXPOSE 8080

ENTRYPOINT ["get-goodmap-versions"]
CMD ["main", "main"]
