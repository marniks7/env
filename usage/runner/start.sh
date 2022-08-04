#!/bin/bash

# https://tekton.dev/docs/dashboard/tutorial/
installTekton() {
  kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
  kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
  kubectl apply -f "${script_dir}"/tekton-dashboard-ingress.yaml
  kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
  kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
}

createCluster() {
  k3d cluster create runner --kubeconfig-update-default -p "80:80@loadbalancer" -p "9097:80@loadbalancer" --registry-create runner-registry --network k3d --api-port 6443 --k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@server:0' \
    --k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@server:0'
}

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
createCluster
installTekton