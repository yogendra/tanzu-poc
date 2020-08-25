#!/bin/bash
export KUBECONFIG=$PWD/.kubeconfig

./01-get-token.sh

kapp deploy -y -a tanzu-system-metrics-server -f 02-metrics-server.yaml
kapp deploy -y -a tanzu-system-cert-manager -f 03-cert-manager
kapp deploy -y -a tanzu-system-ingress -f 04-contour
./04-dns-setup.sh
kapp deploy -y -a tanzu-system-logging -f 05-fluent-bit
kapp deploy -y -a tanzu-sample-app -f 06-httpbin.yaml


curl -L https://httpbin.cluster-3.poc.yogendra.me
