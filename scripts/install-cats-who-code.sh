#!/usr/bin/env bash

# Install and start the Cats Who Code app (for testing purposes, hence the sym-linking of prod to dev app conf)
cd ~/
git clone https://github.com/ryan-blunden/cats-who-code.git
cd cats-who-code
ln -s /home/ec2-user/cats-who-code/app/app.dev.env /home/ec2-user/cats-who-code/app/app.prod.env
make stack

