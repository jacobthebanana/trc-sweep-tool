for index in {01..30}
do gcloud compute tpus tpu-vm delete ${sweeper_vm_prefix}_${index} \
    --project=${gcp_project_id} \
    --zone=${gcp_zone} \
    &

done