#!/usr/bin/env bash

#############################
#  Install Docker on Ubuntu #
#############################

#
# This will install the latest Docker CE release on Ubuntu.
#
# Credit: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository
#

export DEBIAN_FRONTEND=noninteractive

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce
