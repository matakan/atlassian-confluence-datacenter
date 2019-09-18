#!/bin/bash

set -euo pipefail

##Install portworx

#binding clusteradmin role to your user
kubectl create clusterrolebinding myname-cluster-admin-binding \
    --clusterrole=cluster-admin --user=`gcloud info --format='value(config.account)'` 

kubectl apply -f portworx.yml

sleep 20
echo "Portworx installation completed. Waiting until it becomes ready..."

pxpod=$(kubectl get pods -n kube-system | grep "px-" | awk '{print $1}')
kubectl wait --for=condition=Ready pod/${pxpod} -n kube-system --timeout=600s

sleep 30
echo "Now, portworx is ready. Let's have a look at its status..."
PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')
kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl status
