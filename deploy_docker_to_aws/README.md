# Deploy docker container to AWS EC2

[NOTE] 
- Docker images build by M1 Macbook will not work on AWS EC2. Reason because M1 would create linux/arm64 images which work on machines
that are using ARM architecture. But intel machines on AWS uses AMD architecture. 
- Therefore, for M1 machine use the **--platform linux/amd64** option to build the docker image

## What is EC2 instance?
- An EC2 instance is nothing but a virtual server in Amazon Web services terminology.
- It stands for Elastic Compute Cloud.
- It is a web service where an AWS subscriber can request and provision a compute server in AWS cloud.

## STEPS to deploy to AWS EC2

**STEP 1:** Launching EC2 Instance
- refer to AWS doc on how to launch an EC2 instance. 

**STEP 2:** Install Docker on EC2 Instance
- sudo yum install -y docker
- docker --version (ensure docker is installed)
- sudo service docker start
- sudo docker info (it will show docker info as below)
```
[ec2-user@ip-172-31-31-133 ~]$ sudo docker info
Client:
 Context:    default
 Debug Mode: false

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 20.10.7
 Storage Driver: overlay2
  Backing Filesystem: xfs
  Supports d_type: true
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 1
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runtime.v1.linux runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: d71fcd7d8303cbf684402823e425e9dd2e99285d
 runc version: 84113eef6fc27af1b01b3181f31bbaf708715301
 init version: de40ad0
 Security Options:
  seccomp
   Profile: default
 Kernel Version: 5.10.82-83.359.amzn2.x86_64
 Operating System: Amazon Linux 2
 OSType: linux
 Architecture: x86_64
 CPUs: 1
 Total Memory: 965.5MiB
 Name: ip-172-31-31-133.ap-southeast-1.compute.internal
 ID: 7KM4:HV5Q:HJRE:I6WM:SK47:BI7F:K5L3:KOFU:3UJT:4SRR:O3WL:TR7X
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

[ec2-user@ip-172-31-31-133 ~]$ 
```

**STEP 3:** Launch a docker container from dockerhub
- Docker image use from dockerhub => terencechan123/stockcharting-nginx-amd64:1.0
- docker run -d -p 80:80 terencechan123/stockcharting-ngnix-amd64:1.0
