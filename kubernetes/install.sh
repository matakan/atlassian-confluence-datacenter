#!/bin/bash

set -euo pipefail

gcloud config set compute/region "us-west1"
gcloud config set compute/zone "us-west1-c"
gcloud config set project ${1}


#Create a zonal cluster
#Below command creates a 2-node zonal cluster in us-west1-c with auto-scaling enabled.
gcloud container clusters create ${2} \
    --zone us-west1-c \
    --disk-type=pd-ssd \
    --disk-size=30GB \
    --labels=portworx=gke \
    --machine-type=n1-standard-4 \
    --num-nodes=2 \
    --image-type ubuntu \
    --scopes compute-rw,storage-ro \
    --enable-autoscaling --max-nodes=6 --min-nodes=2
gcloud config set container/cluster ${2}
gcloud container clusters get-credentials ${2}
