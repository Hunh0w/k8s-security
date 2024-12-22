#!/bin/bash

helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm install kyverno kyverno/kyverno -n kyverno --create-namespace
helm install falco falcosecurity/falco -n falco --create-namespace

echo "Waiting for kyverno and falco to be ready..."
sleep 30
kubectl apply -f kyverno/

kubectl apply -f registry.yaml

pushd nouns
kubectl apply -f k8s/
popd

pushd verbs
kubectl apply -f k8s/
popd

pushd aggregator
kubectl apply -f k8s/
popd