# (sudo) docker build -t ryba/centos
FROM centos:latest

RUN yum update -y
RUN yum install -y openssh-server openssh-client
