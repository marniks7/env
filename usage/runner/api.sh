#!/bin/bash

changeTerminalTitleRunner() {
  echo -en "\033]0;Runner\a"
}

portForwardTektonDashboard() {
  # not useful approach https://k3d.io/v5.0.0/usage/exposing_services/, it is easier to port forward
  # however docker container should be executed in host network
  nohup kubectl port-forward -n tekton-pipelines service/tekton-dashboard 9097:9097 --pod-running-timeout=5m </dev/null &>/dev/null &
}

infoRunner() {
  echo "====================================="
  echo "Kubernetes API: http://localhost:6443"
  echo "Tekton UI: http://localhost:9097"
  echo "====================================="
}

check_cmd() {
  command -v "$1" >/dev/null 2>&1
}

kubectlSwitchToRunner() {
 if check_cmd "k3d"; then
   k3d kubeconfig merge runner --kubeconfig-merge-default || true
 fi
}