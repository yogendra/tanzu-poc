#!/usr/bin/env bash

SCRIPT_ROOT=$( cd `dirname $0`; pwd)
source $SCRIPT_ROOT/.env

set -e 
echo "Checking Docker runtime"
docker run --rm -t hello-world


 docker ps -a | grep registry &> /dev/null && docker rm -f registry

docker run \
  --restart=always \
  --name registry \
  --hostname registry \
  -v $SCRIPT_ROOT/certificates:/certs \
  -v $SCRIPT_ROOT/registry-data:/var/lib/registry \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/${ROOT_DOMAIN}.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/${ROOT_DOMAIN}.key \
  -p 443:443 \
  -d \
  registry:2

echo "Tag for local registry hello-world => $LOCAL_REGISTY/hello-world"
docker tag hello-world ${LOCAL_REGISTRY}/hello-world

echo "Push image tp ${LOCAL_REGISTRY}/hello-world"
docker push ${LOCAL_REGISTRY}/hello-world

echo "Remove local cached images"
docker rmi -f  ${LOCAL_REGISTRY}/hello-world hello-world

echo "Pull from $LOCAL_REGISTRY/hello-world"
docker pull  ${LOCAL_REGISTRY}/hello-world

echo "Run image from $LOCAL_REGISTRY/hello-world"
docker run  --rm -t ${LOCAL_REGISTRY}/hello-world
