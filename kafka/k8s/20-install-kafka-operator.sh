#!/bin/bash
helm repo add strimzi https://strimzi.io/charts/
helm repo update
helm install kafka-strimzi-operator strimzi/strimzi-kafka-operator --create-namespace --namespace kafka-operator --set watchAnyNamespace=true