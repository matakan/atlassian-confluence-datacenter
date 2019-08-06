kubectl apply -f storage.yml
kubectl apply -f helm_rbac.yml
sleep 5

helm init --service-account tiller 
kubectl get pods --all-namespaces
sleep 20
kubectl get pods --all-namespaces

helm install --name postgres --set postgresqlPassword=confluence_passwd,postgresqlDatabase=confluence,postgresqlUsername=confluence_user,persistence.existingClaim=postgres-pvc postgresql_helm
