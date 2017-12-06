#!/usr/bin/env bash

# Update System
yum update -y
yum install -y docker git

# Start Docker now that it is installed
service docker start

