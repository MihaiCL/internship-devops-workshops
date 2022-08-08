#!/bin/bash
HELM_VERSION=3.6.0

if [ -f /usr/local/bin/helm ]
then
  echo file already exists: /usr/local/bin/helm
  echo remove it if you with to re-install
  exit 1
fi


wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
tar xzvf helm-v${HELM_VERSION}-linux-amd64.tar.gz
chmod +x linux-amd64/helm
sudo cp linux-amd64/helm /usr/local/bin

rm helm-v${HELM_VERSION}-linux-amd64.tar.gz
rm -rf linux-amd64