#!/bin/bash

changeTerminalTitleTarget() {
  echo -en "\033]0;Target\a"
}

portForwardApp() {
  nohup kubectl port-forward -n default service/guestbook-release 3000:3000 --pod-running-timeout=5m </dev/null &>/dev/null &
}

infoTarget() {
  echo "====================================="
  echo "Kubernetes API: http://localhost:6444"
  echo "Chaos Mesh UI: http://localhost:2333"
  echo "Chaos Mesh Secret:"
  local chaosmesh_secret=$(kubectl get secret | grep account-cluster-manager | awk '{ print $1 }')
  kubectl get secret "$chaosmesh_secret" -o jsonpath='{ .data.token }' | base64 -d && echo
  echo "====================================="
}

check_cmd() {
  command -v "$1" >/dev/null 2>&1
}

kubectlSwitchToTarget() {
 if check_cmd "k3d"; then
   k3d kubeconfig merge target --kubeconfig-merge-default || true
 fi
}