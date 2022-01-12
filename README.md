# FSJ_DOCKER

# Installation
- Download docker from docker website
- Install it an run
- A whale image will appear above the notification bar. Click and ensure status shows running

# Concept
## Images
- Images are read only template used to create containers
- Images are created with the docker build command, either by us or by other docker users
- Images are composed of layers of other images
- Images are stored in a Docker registry

## Containers
- Containers are created from images. If an image is a class, then a container is an instance of a class - runtime library
- Containers are lightweight and portable encapsulations of an environement in which to run applications
- Inside a container, it has all the binaries and **dependencies** needed to run the application. Self sufficient

## Registry and Repositories
- A registry is where we store our images
- You can host your own registry or you can use Docker's public registry which is called DockerHub
- Inside registry, images are stored in repositories
- Docker repository is a collection of different docker images with the same name that have different tags, each tag represents different version

# Docker Hub
(A public docker registry - hub.docker.com)
- Official repo are certified repo by docker
- Official images has clear documentation with docker team reviewing image content
- Security update in a timely manner

# Docker Container's Basic CMD
(Try it at terminal when docker is running)
- docker info (system wide info about docker)
- docker images (list out available images in local box)
- docker run <image name>:<tag> (if the image is not in local box, docker will download from remote docker registry)
  - e.g. docker run busybox:latest echo "hello world" (busybox The Swiss Army Knife of Embedded Linux)
  - docker run spin up a new image
- docker run -i -t <image name>:<tag>
  - -i flag starts an interactive container
  - -t flag creates a pseudo-TTY that attached stdin and stdout
  
# Docker Container Deep Dive
  
