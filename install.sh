#!/bin/bash
kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.2.0" | kubectl apply -f -;
if [ command -v istioctl 2> /dev/null ]; then
    istioctl install --set profile=minimal -y;
else
    curl -L https://istio.io/downloadIstio | sh - && istio-*/bin/istioctl install --set profile=minimal -y;
fi
kubectl label namespace default istio-injection=enabled

helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm install falco falcosecurity/falco -n falco --create-namespace
helm install kyverno kyverno/kyverno -n kyverno --create-namespace

if [[ $? -eq 0 ]]; then
    echo "Waiting for kyverno and falco to be ready..."
    sleep 30
fi
kubectl apply -f kyverno/
kubectl apply -f istio/
kubectl apply -f registry.yaml

if [[ $? -eq 0 ]]; then
    echo "Waiting for the registry to be ready..."
    sleep 10
fi

pushd nouns
./deploy.sh
popd

pushd verbs
./deploy.sh
popd

pushd aggregator
./deploy.sh
popd