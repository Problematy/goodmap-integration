# Goodmap Integration

## Docker

### Building image

To build docker image you have to provide `BACKEND_VERSION` of goodmap, e.g.:
> docker build . -t goodmap --build-arg BACKEND_VERSION=0.1.7 

### Running in docker

To run goodmap engine locally you have to expose two ports:
- 5000 - always
- 8080 - optional - if you run custom frontend 


As you could see `run-goodmap.sh` is entrypoint in our docker image. You can run its contend
(serve goodmap) with its `main` function.

To run custom version of backend and frontend use `BACKEND_VERSION` and `FRONTEND_BACKEND`
accordingly.

To sum up it could be something like this:

> docker run -p 5000:5000 -p 8080:8080 -e BACKEND_VERSION=0.1.6 -e FRONTEND_VERSION=0.1.6  goodmap main
