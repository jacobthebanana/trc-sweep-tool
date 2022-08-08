#!/bin/bash

# Copy project folder to local drive.
cp -avr /mnt/swift/project ~/project

export PYTHON=~/project/env/bin/python3

# Setup wandb tunneling through SSH and authenticate.
sudo ssh -f \
    -o StrictHostKeyChecking=accept-new \
    -i ${relay_ssh_private_key_path} \
    -L 127.0.0.1:443:${wandb_api_host}:443 \
    ${relay_login_user}@${relay_private_ip} tail -f /dev/null
 
echo "127.0.0.1 ${wandb_api_host}" | sudo tee -a /etc/hosts
${PYTHON} -m wandb login --cloud ${wandb_api_key}

