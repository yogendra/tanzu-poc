#!/bin/bash

./01-get-token.sh

kapp deploy -y -a tanzu-system-metrics-server -f 02-metrics-server
kapp deploy -y -a tanzu-system-cert-manager -f tkg-extensions-v1.1.0/cert-manager
./04-tag-subnet.sh
kapp deploy -y -a tanzu-system-ingress -f tkg-extensions-v1.1.0/ingress/contour/aws
./05-dns-setup.sh

kapp deploy -y -a tanzu-sample-app -f 06-httpbin

helm template tanzu-efk stable/elastic-stack  --values elasticstack-param.yaml --create-namespace -n tanzu-efk      --include-crds  > 07-elastic-stack/02-elastic-stack.yaml
kapp deploy -y -a tanzu-efk --map-ns default=tanzu-efk -f 07-elastic-stack

helm template tanzu-harbor harbor/harbor  --values harbor-param.yaml --create-namespace -n tanzu-harbor --include-crds > 08-harbor/03-harbor.yaml
kapp deploy -y -a tanzu-harbor --map-ns default=tanzu-harbor -f 08-harbor



curl -L https://httpbin.cluster-3.poc.yogendra.me
