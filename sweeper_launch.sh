#!/bin/bash
PYTHON=~/project/env/bin/python3
cd ~/project/
source ~/project/env/bin/activate
export TRANSFORMERS_CACHE=/mnt/swift/cache
export HF_DATASETS_CACHE="/dev/shm"
${PYTHON} -m wandb agent ${wandb_sweep}