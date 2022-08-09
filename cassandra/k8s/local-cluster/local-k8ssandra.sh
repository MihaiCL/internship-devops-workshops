#!/usr/bin/env bash
helm repo add k8ssandra https://helm.k8ssandra.io/stable
helm repo update

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
     --namespace cert-manager --create-namespace --set installCRDs=true

helm install -f k8ssandra-helm.yaml k8ssandra k8ssandra/k8ssandra --namespace k8ssandra --create-namespace

kubectl describe CassandraDataCenter dc1 --namespace k8ssandra | grep "Cassandra Operator Progress:"