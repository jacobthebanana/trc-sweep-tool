# Hyperparameter Sweeps on Preemptible TPU VMs
Scripts for launching hyperparameter sweeps on preemptible TPU VMs without
an external IP address or internet access, assuming that there is at least one 
"relay" VM in the same zone with an external IP address (and internet connectivity.) 

# Script naming
Scripts starting with `gcloud` are meant to be run in the GCP cloud shell.
Scripts starting with `sweeper_` are meant to be ran on the sweeper TPU VMs 
(preemptible, no access to the internet.) 