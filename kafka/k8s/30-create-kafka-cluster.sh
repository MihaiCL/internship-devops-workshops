#!/bin/bash
kubectl create ns kafka-devops-cluster
kubectl apply -f ./kafka-cluster.yaml