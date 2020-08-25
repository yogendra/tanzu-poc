#!/usr/bin/env bash

CHARS=(
  stable/elastic-stack \
  harbor/harbor
)
IMAGES=(\
  nginx \
  ubuntu \
  busybox
  busybox:latest \
  dduportal/bats:0.4.0 \
  docker.elastic.co/elasticsearch/elasticsearch-oss:6.8.2 \
  docker.elastic.co/kibana/kibana-oss:6.7.0 \
  docker.io/bitnami/redis:6.0.6-debian-10-r10 \
  docker.io/jettech/kube-webhook-certgen:v1.2.2 \
  dwdraju/alpine-curl-jq \
  fluent/fluent-bit:1.3.2 \
  gcr.io/apigee-microgateway/helloworld:latest \
  gcr.io/kuar-demo/kuard-amd64:1 \
  gcr.io/kubernetes-e2e-test-images/resource-consumer:1.5 \
  goharbor/chartmuseum-photon:v2.0.2 \
  goharbor/clair-adapter-photon:v2.0.2 \
  goharbor/clair-photon:v2.0.2 \
  goharbor/harbor-core:v2.0.2 \
  goharbor/harbor-db:v2.0.2 \
  goharbor/harbor-jobservice:v2.0.2 \
  goharbor/harbor-portal:v2.0.2 \
  goharbor/harbor-registryctl:v2.0.2 \
  goharbor/notary-server-photon:v2.0.2 \
  goharbor/notary-signer-photon:v2.0.2 \
  goharbor/redis-photon:v2.0.2 \
  goharbor/registry-photon:v2.0.2 \
  goharbor/trivy-adapter-photon:v2.0.2 \
  jenkins/inbound-agent:4.3-4 \
  jenkins/jenkins:lts \
  jettech/kube-webhook-certgen:v1.0.0 \s
  k8s.gcr.io/metrics-server/metrics-server:v0.3.7 \
  kiwigrid/k8s-sidecar:0.1.144 \
  kubernetesui/dashboard:v2.0.0 \
  kubernetesui/metrics-scraper:v1.0.4 \
  quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.31.0 \
  us.gcr.io/k8s-artifacts-prod/ingress-nginx/controller:v0.34.1@sha256:0e072dddd1f7f8fc8909a2ca6f65e76c5f0d2fcfb8be47935ae3457e8bbceb20 \
  vmware-docker-tkg.bintray.io/cert-manager/cert-manager-cainjector:v0.11.0_vmware.1 \
  vmware-docker-tkg.bintray.io/cert-manager/cert-manager-controller:v0.11.0_vmware.1 \
  vmware-docker-tkg.bintray.io/cert-manager/cert-manager-webhook:v0.11.0_vmware.1 \
  vmware-docker-tkg.bintray.io/contour:v1.2.1_vmware.1 \
  vmware-docker-tkg.bintray.io/envoy:v1.13.1_vmware.1 \
  vmware-docker-tkg.bintray.io/fluent-bit:v1.3.8_vmware.1 \
  yogendra/hello-app:1.1 \
  yogendra/httpbin \
  yogendra/tmc-cluster-autoscaler:1e29f3d \
  yogendra/tmc-cluster-autoscaler:9eb6141 \
  yogendra/tmc-cluster-autoscaler:a041da2 \
)
