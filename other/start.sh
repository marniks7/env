#!/bin/bash

# https://tekton.dev/docs/dashboard/tutorial/
tekton() {
  kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
  kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
  # not useful approach https://k3d.io/v5.0.0/usage/exposing_services/, it is easier to port forward
  nohup kubectl port-forward -n tekton-pipelines service/tekton-dashboard 9097:9097 --pod-running-timeout=5m </dev/null &>/dev/null &
}

# https://chaos-mesh.org/docs/production-installation-using-helm/
chaosMesh() {
  helm repo add chaos-mesh https://charts.chaos-mesh.org
  kubectl create ns chaos-testing
  helm install chaos-mesh chaos-mesh/chaos-mesh -n=chaos-testing --version 2.2.2
  kubectl apply -f "$dir"/chaos-mesh-rbac.yaml
  nohup kubectl port-forward -n chaos-testing service/chaos-dashboard 2333:2333 --pod-running-timeout=5m </dev/null &>/dev/null &

}
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

k3d cluster create --api-port 6443
tekton
chaosMesh
"$dir"/info.sh
