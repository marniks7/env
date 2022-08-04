#!/bin/bash

# https://chaos-mesh.org/docs/production-installation-using-helm/
installChaosMesh() {
  helm repo add chaos-mesh https://charts.chaos-mesh.org
  kubectl create ns chaos-testing
  helm install chaos-mesh chaos-mesh/chaos-mesh -n=chaos-testing --version 2.2.2 --set dashboard.securityMode=false
  kubectl apply -f "$script_dir"/chaos-mesh-rbac.yaml
  kubectl apply -f "${script_dir}"/chaos-mesh-dashboard-ingress.yaml
}

installApp() {
  # https://github.com/IBM/helm101/tree/master/charts/guestbook
  helm repo add helm101 https://ibm.github.io/helm101/
  helm install guestbook-release helm101/guestbook
  # out-of-the-box redis is old and not configured for master-slave replication
  kubectl delete deployment redis-master
  kubectl delete deployment redis-slave
  kubectl delete service redis-master
  kubectl delete service redis-slave
  # https://github.com/bitnami/charts/tree/master/bitnami/redis/
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm install redis --set fullnameOverride=redis --set auth.enabled=false bitnami/redis
}

createCluster() {
  k3d cluster create target --kubeconfig-update-default --registry-create target-registry -p "2333:80@loadbalancer" --network k3d --api-port 6444 --k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@server:0' \
    --k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@server:0'
}

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
set -euxo pipefail
createCluster
installChaosMesh
installApp
