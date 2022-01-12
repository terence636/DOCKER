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
- docker run -it --rm -p 8888:8080 tomcat:latest (map the container port to host port: 8888. Container port is 8080)

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

## Using Docker file
- Dockerfile is a text document that contains all the instructions users provide to assemble an image
```
FROM debian:latest
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y vim    
```
- docker build -t terencechan123/debian .
- docker build command takes the path to the build context as an argmument. In the above it is the current directory
- When build starts, docker client pack all files in the build context into a tarball then transfer the tarball file to the docker daemon
- By default docker would search for the Dockerfile in the build context path. If not then need to provide a -f option
- Each RUN command will execute the command on the top writable layer of the container, then commit the container as a new image.
- The new image is used for the next step in the Dockerfile. So each RUN instruction will create a new image layer.
- It is recommended to chain the RUN instructions in the Dockerfile to reduce the number of image layers it creates.
    
```
FROM debian:latest
RUN apt-get update && apt-get install -y git vim
```
- **CMD** instruction specifies what command you want to run when the container starts up.
- If we don't specify CMD instruction in the Dockerfile, Docker will use the default command defined in the base image.
- The CMD instruction doesn't run when building the image, it only runs when the container starts up.
- You can specify the command in either exec form which is preferred or in shell form.
```
FROM debian:latest
RUN apt-get update && apt-get install -y git vim
CMD ["echo", "hello terence"]   
```    

## Docker Build Cache
- Will not run the same instruction again if the build version is the same
- To bypass cache use --no-cache=true option

    
## Docket COPY
- We can use COPY command to copy our project files into the container
  - e.g then do a npm install to install all dependencies and use the CMD to start the app when container starts
    
# Push images to docker hub
- to change the name of images 
```
docker tag <image id> <dockerhub id>/<image name>:<tag>
```
- try not to use latest tag. 
- login to docker hub and push
```
docker login --username=<dockerhub id>
docker push <dockerhub id>/<image name>:<tag>
```

# Example of Containerized Web Application using Flask
- Below is Dockerfile
- FROM is inidicating the base images used. If the image is not avail locally it will download from remote registry
```
FROM python:3.5
RUN pip install Flask==0.11.1
RUN useradd -ms /bin/bash admin
USER admin
WORKDIR /app
COPY app /app
CMD ["python", "app.py"]     
```
- The app.py is inside a folder called app that is same directory with Dockerfile. COPY app /app will copy content of app folder from current directory to container /app directory
- Run docker build -t dockerapp:v0.1 . (this will build an image called dockerapp with version v0.1
- docker run -it -d -p 5001:5000 dockerapp:v0.1 to run the container in the background with port mapping to 5001
- The CMD will launch the python app.py once the container started
    
# Container Links
- run 2 containers and link them together
- For example run redis and run an app
- docker ps to check the app and redis container id. Run the bash and check the etc/hosts file to see the DNS mapping
- You will see that the container local private ip address is 172.17.0.3 for app and 172.17.0.2 for redis. both are in the private network
- so how to inform both dockerapp container to know redis ip address? Use container links    
- stop the dockerapp 
- link redis to dockerapp using --link flag. Check dockerapp hosts file again to confirm
- The advantage here is we do not need to expose redis ip
```
docker run -d dockerapp:v0.1
docker run -d redis:latest
docker ps
docker exec -it <container id> bash
more /etc/hosts
docker stop <dockerapp id>
docker run -d -p 5001:5000 --link <redis id> dockerapp:v0.1
``
    
# Automate Workflow with docker compose
- Manual linking containers and configuring services become impractical when number of containers grow. Hence need docker compose
- Docker compose is like "network switch" in LAN. It consists of a yml file that spelt out the details of linking and dependencies and configuration of containers
- to start all containers, run docker-compose up
- run docker-compose ps or docker ps to check all containers are up and runnning
- run docker-compose logs to see the logs 
- docker-compose logs <container id> to see logs for that particular container
- docker-compose logs -f to tail the logs
- docker-compose stop without removing the containers
- docker-compose rm to stop and remove all containers
- docker-compose up will not build the images if already exist. When changes on Dockerfile and to rebuild image, use docker-compose build

# Docker Networking
- 4 types of network
    - none
    - bridge
    - host
    - overlay
- use docket network ls to list out type of networks
- none network is isolated container. It doesnt has access to outside world. The benefits is max network protection
- to run none network, execute run as docker run -d **--net none** ....
- bridge network is similar to LAN. Run the docker network inspect bridge command to see the IP for diff containers and bridge gateway ip too
- bridge network is the default network when run containers
- Containers from 2 different bridge cant communicate with each other by default. How to connect them?
- Use docket network connect .... (see doc)
```
docker network ls
docker network inspect bridge
docker create --driver bridge my_another_bridge_network
docker run -d --net my_another_bridge_network ... 
docker network inspect my_another_bridge_network
```
