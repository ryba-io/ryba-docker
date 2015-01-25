# (sudo) docker build -t ryba/centos
FROM centos:latest
MAINTAINER Pierre Sauvage <pierre@adaltas.com>

RUN yum update -y

RUN yum install -y passwd openssh openssh-server openssh-clients sudo

## Create user
RUN useradd ryba
# Set a (random) password, mandatory for ssh connection, even if key authentification is used
RUN echo ryba:`date +%s | sha256sum | base64 | head -c 16` | chpasswd

## Set up SSH
RUN mkdir -p /home/ryba/.ssh; chown ryba /home/ryba/.ssh; chmod 700 /home/ryba/.ssh
ADD .authorized_keys /home/ryba/.ssh/authorized_keys
RUN chown ryba /home/ryba/.ssh/authorized_keys
RUN chmod 600 /home/ryba/.ssh/authorized_keys
RUN mkdir -p /root/.ssh/
RUN cp /home/ryba/.ssh/authorized_keys /root/.ssh/

## setup sudoers
RUN echo "ryba ALL=(ALL) ALL" >> /etc/sudoers.d/docker

## Set up SSHD config
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
# PAM module seems to cause some troubles
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN /usr/bin/ssh-keygen -A

