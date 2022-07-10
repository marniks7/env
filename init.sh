#!/bin/bash

check_cmd() {
  command -v "$1" >/dev/null 2>&1
}

if check_cmd "k3d"; then
  k3d kubeconfig merge --kubeconfig-merge-default || true
fi
