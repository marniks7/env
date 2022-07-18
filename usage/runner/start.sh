#!/bin/bash

# https://tekton.dev/docs/dashboard/tutorial/
tekton() {
  kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
  kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
}

createRunner() {
  k3d cluster create runner --kubeconfig-update-default --registry-create runner-registry --network k3d --api-port 6443 --k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@server:0' \
    --k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@server:0'
  tekton
}

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

createRunner