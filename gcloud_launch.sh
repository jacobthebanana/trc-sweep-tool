#!/bin/bash
gcloud compute disks create ${destination_disk_name} \
    --type=pd-ssd \
    --size=${disk_capacity} \
    --zone=${gcp_zone} \
    --source-disk=projects/${gcp_project_id}/zones/${gcp_zone}/disks/${source_disk_name}


for index in {01..30}
do gcloud compute tpus tpu-vm create ${sweeper_vm_prefix}_${index} \
    --project=${gcp_project_id} \
    --zone=${gcp_zone} \
    --accelerator-type=${gcp_accelerator_type} \
    --version=${gcp_tpu_vm_software_version} \
    --preemptible \
    --internal-ips \
    --subnetwork default \
    --data-disk source=projects/${gcp_project_id}/zones/${gcp_zone}/disks/${destination_disk_name},mode=read-only \
    --metadata startup-script='#! /bin/bash
        sudo mkdir -pv /mnt/swift
        sudo mount -o noload /dev/sdb /mnt/swift
        source /mnt/swift/.env
        cd /mnt/swift
        bash sweeper_setup.sh
        bash sweeper_launch.sh
        EOF' \
    &

done