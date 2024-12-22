#!/bin/bash

SVC_TAG="verbs:latest"
REGISTRY="10.43.0.50:5000"

docker build -t ${REGISTRY}/$SVC_TAG .
docker push ${REGISTRY}/$SVC_TAG

docker image prune -f
kubectl rollout restart deploy/verbs
if [[ ! $? -eq 0 ]]; then
  kubectl apply -f k8s
fi
