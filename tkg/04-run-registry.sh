#!/usr/bin/env bash

SCRIPT_ROOT=$( cd `dirname $0`; pwd)
source $SCRIPT_ROOT/.env


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
  registry:2



 docker tag hello-world registry-tkg-vmware-run.poc.yogendra.me/hello-worlddocker push registry-tkg-vmware-run.poc.yogendra.me/hello-worlddocker rmi  registry-tkg-vmware-run.poc.yogendra.me/hello-worlddocker rmi  hello-world
From Me to Everyone: (18:09)
docker pull  registry-tkg-vmware-run.poc.yogendra.me/hello-worlddocker run  registry-tkg-vmware-run.poc.yogendra.me/hello-world
