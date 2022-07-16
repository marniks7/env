#!/bin/bash

# https://tekton.dev/docs/dashboard/tutorial/
tekton() {
  kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
  kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
}

# https://chaos-mesh.org/docs/production-installation-using-helm/
chaosMesh() {
  helm repo add chaos-mesh https://charts.chaos-mesh.org
  kubectl create ns chaos-testing
  helm install chaos-mesh chaos-mesh/chaos-mesh -n=chaos-testing --version 2.2.2 --set dashboard.securityMode=false
  kubectl apply -f "$dir"/chaos-mesh-rbac.yaml
}

# runner should be created BEFORE 'target' due to 'registry-create' \ 'registry-use'
createRunner() {
  k3d cluster create runner --kubeconfig-update-default --registry-create mycluster-registry --network k3d --api-port 6443 --k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@server:0' \
    --k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@server:0'
  tekton
}

# target should be created AFTER 'runner' due to 'registry-create' \ 'registry-use'
createTarget() {
  k3d cluster create target --kubeconfig-update-default --registry-use mycluster-registry --network k3d --api-port 6444 --k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@server:0' \
    --k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@server:0'
  chaosMesh
}
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

createRunner
createTarget