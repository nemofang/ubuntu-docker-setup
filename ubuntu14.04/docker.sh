#!/bin/bash

# Update package information, ensure that APT works with the https method, and that CA certificates are installed.
apt-get update
apt-get install -y apt-transport-https ca-certificates
# install curl
apt-get install -y curl

# Add the new GPG key.
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Add docker entry for your Ubuntu operating system.
echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list # 14.04
# file="/etc/apt/sources.list.d/docker.list"
# if [ -f "$file" ]
# then
#   touch /etc/apt/sources.list.d/docker.list
#   echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list
# else
#   echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list
# fi

# Update the APT package index.
apt-get update

# Purge the old repo if it exists.
apt-get purge lxc-docker

# Verify that APT is pulling from the right repository.
apt-cache policy docker-engine

# install the linux-image-extra package for your kernel version:
apt-get install -y linux-image-extra-$(uname -r)
apt-get install -y apparmor

# Install docker engine
apt-get update
apt-get install -y docker-engine

# Start the docker daemon.
service docker start

# add docker group and add ubuntu to it
groupadd docker
usermod -a -G docker ubuntu
# unset DOCKER_HOST

# Install docker compose 1.7.0
curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# exit
exit
