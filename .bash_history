./other/start.sh
ls
ls
ls
kubectl get pods --all-namespaces 
kubectl get pods --all-namespaces 
kubectl get pods --all-namespaces 
helm upgrade chaos-mesh chaos-mesh/chaos-mesh -n=chaos-testing --version 2.2.2
k3d cluster delete
./other/start.sh
exit
./other/start.sh
./other/start.sh
./other/start.sh
./other/start.sh
./other/start.sh
./other/start.sh
kubectl get pods --namespace chaos-testing -l app.kubernetes.io/instance=chaos-mesh
kubectl describe pod -n chaos-testing chaos-dashboard-66dd7dfdb9-smtgp 
