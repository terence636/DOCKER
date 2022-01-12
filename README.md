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

# Docker Container's CMD
(Try it at terminal when docker is running)
- docker pull \<image name> (download image)
- docker info (system wide info about docker)
- docker images (list out available images in local box)
- docker run \<image name>:<tag> (if the image is not in local box, docker will download from remote docker registry)
  - e.g. docker run busybox:latest echo "hello world" (busybox The Swiss Army Knife of Embedded Linux)
  - docker run spin up a new image
- docker run -i -t \<image name>:<tag>
  - i flag starts an interactive container
  - t flag creates a pseudo-TTY that attached stdin and stdout
- docker ps (showing the current active containers)
- docker ps -a (showing all active and non active containers)
- docker run -d flag run container in background. Console can be used after the container is started up
  - e.g. docker run -d busybox@latest sleep 60 and do a docker ps (container active for 60secs)
- docker run --rm flag removes the container after it becomes inactive
- docker run --name creates a name for the docker. Or else is randomly assigned
  e.g. docker run --name terence busybox:latest
- docker inspect \<container id> displays low level info abt container or image in JSON format

## Docker Port Mapping
- docker run -it --rm -p 8888:8080 tomcat:latest (map the container port to 8888)

## Docker Logs
- E.g docker run -it --rm -p -d 8888:8080 tomcat:latest will return the container's ID
  Do a docker logs \<container's ID> to see the logs

# Working with Docker Images
- An image consist of multiple layers
- Each layer is another image
- Run docker history busybox:latest to see the layers
- Changes are made to thin R/W layer that stack ontop of existing layers.
- Those R/W layers will be removed once the container is destroyed
    
# Build docker Image
- 2 ways: (1) Commit changes made in a docker container (2) Write a dockerfile

## Commit changes
- For example run debian images
- Install git into debian container
- Exit the container and do a docker ps -a to get the container ID
- Run docker commit \<container id> \<hub id>:<version>
- Run docker images to see that the new image is created
- Run the new image
- Check that git already installed

