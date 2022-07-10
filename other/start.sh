#!/bin/bash

k3d create cluster
k3d kubeconfig merge --kubeconfig-merge-default
kubectl get pods
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
