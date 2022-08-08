#!/bin/bash
gcloud compute disks create ${destination_disk_name} \
    --type=pd-ssd \
    --size=${disk_capacity} \
    --zone=${gcp_zone} \
    --source-disk=projects/${gcp_project_id}/zones/${gcp_zone}/disks/${source_disk_name}


for index in {01..30} 
do gcloud compute tpus tpu-vm create ${swift_vm_prefix}_${index} \
    --project=${gcp_project_id} \
    --zone=${gcp_zone} \
    --accelerator-type=${gcp_accelerator_type} \
    --version=${gcp_tpu_vm_software_version} \
    --metadata startup-script='#! /bin/bash
        # Setup shared disk (read-only)
        sudo mkdir -pv /mnt/swift
        sudo mount -o discard,defaults /dev/sdb /mnt/swift
        source /mnt/swift/.env
        bash swift_setup.sh
        bash sweep_launch.sh
        EOF'

done