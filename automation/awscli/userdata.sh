#!/bin/bash

# Update System
yum update -y
yum install -y docker git make nano telnet

# TODO - Determine the version of docker installed and download the corresponding version of docker-compose
curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Start Docker now that it is installed
service docker start

# Install and start the Cats Who Code app
cd /home/ec2-user
git clone https://github.com/ryan-blunden/cats-who-code.git
cd cats-who-code
make stack ARGS=-d --build --remove-orphans
