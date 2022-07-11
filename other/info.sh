#!/bin/bash

info() {
  echo "====================================="
  echo "Kubernetes API: http://localhost:6443"
  echo "Tekton UI: http://localhost:9097"
  echo "Chaos Mesh UI: http://localhost:2333"
  echo "Chaos Mesh Secret:"
  local chaosmesh_secret=$(kubectl get secret | grep account-cluster-manager | awk '{ print $1 }')
  kubectl get secret "$chaosmesh_secret" -o jsonpath='{ .data.token }' | base64 -d && echo
  echo "====================================="
}

info