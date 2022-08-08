#!/bin/bash

# Copy project folder to local drive.
cp -ar /mnt/sweeper/project ~/project
ln -s /mnt/sweeper/data ~/project/data

PYTHON=~/project/env/bin/python3

# Setup wandb tunneling through SSH and authenticate.
ssh -L 127.0.0.1:443:${wandb_api_host}:443 ${relay_login_user}@${relay_private_ip} &
echo "127.0.0.1 ${wandb_api_host}" | sudo tee -a /etc/hosts
${PYTHON3} -m wandb login --cloud ${wandb_api_key}

