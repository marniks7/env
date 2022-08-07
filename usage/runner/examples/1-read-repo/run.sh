#!/bin/bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

kubectl apply -f "${script_dir}"/git-credentials.yaml
#https://hub.tekton.dev/tekton/task/git-clone
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.7/git-clone.yaml
kubectl apply -f "${script_dir}"/show-readme.yaml
kubectl apply -f "${script_dir}"/pipeline.yaml
kubectl create -f "${script_dir}"/run.yaml