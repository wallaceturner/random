#!/bin/bash
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
usermod -aG docker $USER

#How do I expose the docker API over TCP?
#https://serverfault.com/questions/843296/how-do-i-expose-the-docker-api-over-tcp

#docker run hello-world

#remove a container
#docker rm 2ab19c3aa520 --force