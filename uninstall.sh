#!/bin/bash

pushd nouns
kubectl delete -f k8s/
popd

pushd verbs
kubectl delete -f k8s/
popd

pushd aggregator
kubectl delete -f k8s/
popd


kubectl delete -f kyverno/

helm uninstall kyverno kyverno/kyverno
helm uninstall falco falcosecurity/falco

kubectl delete ns kyverno
kubectl delete ns falco

kubectl delete -f registry.yaml

