# Goodmap Integration

## Docker

### Building image

To build docker image you have to provide `BACKEND_VERSION` of goodmap, e.g.:
> docker build . -t goodmap --build-arg BACKEND_VERSION=0.1.7 

### Running in docker

As you could see `run-goodmap.sh` is entrypoint in our docker image. You can run its contend
(serve goodmap) with its `main` function:
> docker run goodmap main

To make this accessible you have to expose at least port on which app is served:
> docker run -p 8080:8080 goodmap main
