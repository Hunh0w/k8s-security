#!/bin/bash

SVC_TAG="10.43.0.50:5000/aggregator:latest"

docker build -t $SVC_TAG .
docker push $SVC_TAG

docker image prune -f
kubectl rollout restart deploy/aggregator
if [[ ! $? -eq 0 ]]; then
  kubectl apply -f k8s
fi