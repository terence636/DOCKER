FROM debian:latest
RUN apt-get update && apt-get install -y git vim
CMD ["echo", "hello terence"]