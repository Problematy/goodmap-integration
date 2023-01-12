# Goodmap Integration

## Docker

### Building image

To build docker image you have to provide `BACKEND_VERSION` and `FRONTEND_VERSION` of goodmap, e.g.:
> docker build . -t goodmap --build-arg BACKEND_VERSION=0.1.7 --build-arg FRONTEND_VERSION=0.1.6

### Running in docker

To run goodmap engine locally you have to expose two ports:
- 5000 - backend
- 8080 - frontend

To run default version of goodmap (frontend and backend that image was built with) run this command:

> docker run -p 5000:5000 -p 8080:8080 goodmap main

To run custom version of backend and frontend use `BACKEND_VERSION` and `FRONTEND_BACKEND`
accordingly:

> docker run -p 5000:5000 -p 8080:8080 -e BACKEND_VERSION=0.1.X -e FRONTEND_VERSION=0.1.X goodmap main

You can also run your local version of app mounting directory with backend or frontend code like this:

> docker run -p 5000:5000 -p 8080:8080 -v <your-frontend-directory>:/home/john/frontend/goodmap -v <your-backend-directory>:/home/john/backend/goodmap goodmap main
