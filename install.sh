#!/bin/bash

helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm install falco falcosecurity/falco -n falco --create-namespace
helm install kyverno kyverno/kyverno -n kyverno --create-namespace

echo "Waiting for kyverno and falco to be ready..."
sleep 30
kubectl apply -f kyverno/

kubectl apply -f registry.yaml

pushd nouns
./deploy.sh
popd

pushd verbs
./deploy.sh
popd

pushd aggregator
./deploy.sh
popd