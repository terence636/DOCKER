## Overview
1. Create a Dockerfile for the React application
2. Create React application Docker image from the Dockerfile
3. Push the Docker Image to the Docker Hub
4. Run the Docker Container
5. Why Multi-Stage Docker Builds are better

## Prerequisites
1. Docker: To check if it is installed or not, rundocker -v command
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


