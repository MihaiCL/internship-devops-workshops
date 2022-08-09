#!/usr/bin/env bash
helm repo add k8ssandra https://helm.k8ssandra.io/stable
helm repo update

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
     --namespace cert-manager --create-namespace --set installCRDs=true

helm install k8ssandra-operator k8ssandra/k8ssandra-operator -n k8ssandra-operator --create-namespace --set global.clusterScoped=true