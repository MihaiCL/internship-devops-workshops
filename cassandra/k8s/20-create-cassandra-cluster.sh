#!/usr/bin/env bash
kubectl create ns cassandra-devops-cluster
kubectl apply -f ./k8ssandra.yaml --namespace cassandra-devops-cluster