## Overview
1. Create a Dockerfile for the React application
2. Create React application Docker image from the Dockerfile
3. Push the Docker Image to the Docker Hub
4. Run the Docker Container
5. Why Multi-Stage Docker Builds are better

## Prerequisites
1. Docker: To check if it is installed or not, run docker -v command
2. Node.js: To check if it is installed or not, run node -v command
3. Docker Hub account(optional): if you want to publicly share your application by pull and push Docker images.
4. React.js application

## Let's Get Started

**STEP 1:**
- Create a docker file in the **main folder** (folder that contain package.json file) named Dockerfile without any extension
```
# pull official base image
FROM node:10

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
# copies package.json and package-lock.json to Docker environment
COPY package.json ./
COPY package-lock.json ./
# Installs all node packages
RUN npm install 

# Copies everything over to Docker environment
COPY . ./
EXPOSE 3000
# start app
CMD ["npm", "start"]
```

**STEP 2:**
- Create a dockerignore file in the main folder named .dockerignore without any extension
```
/node_modules
/build
.git
*.md
.gitignore
```

**STEP 3:**
- Create React Application docker image from the dockerfile
  - ensure docker engine is started before building the app
```
docker build -t <app-name>
```
  - if wanna push to remote docker registry such as dockerhub
```
docker build -t <hub-user>/<app-name>[:<tag>]

e.g docker build -t myhub/myapp:v1.0
```
- run docker images to list out all images at local repo and ensure your app images is avail

**STEP 4:**
- Run and test the docker container
```
docker run --rm -it -p 3000:3000 myapp
```
- Open http://localhost:3000 to view your application in the browser

**STEP 5:** (Optional)
- Push Docker image to dockerhub
```
docker push <hub-user>/<app-name>:<tag>
```

## Using multi-stage build (more applicable for frontend and backend app)
- Stage 1: Build app
- Stage 2: Use NGINX to serve the app
- Dockerfile as follows:-
```
# pull official base image
FROM node:10 AS builder

# set working directory
WORKDIR /app


# install app dependencies
#copies package.json and package-lock.json to Docker environment
COPY package.json ./

# Installs all node packages
RUN npm install 


# Copies everything over to Docker environment
COPY . ./
RUN npm run build

#Stage 2
#######################################
#pull the official nginx:1.19.0 base image
FROM nginx:1.19.0
#copies React to the container directory
# Set working directory to nginx resources directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static resources
RUN rm -rf ./*
# Copies static resources from builder stage
COPY --from=builder /app/build .
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]

```
- docker build --no-cache -t <app-name>:<tag>
- docker images (to check image is build)
- docker run --rm -it -p 8080:80 <app-name>:<tag>
- docker ps (to check docker container is active and running)
- go to browser localhost:8080
- docker exec -it <container id> bash (to run bash inside the container. the id can get from docker ps)
