#!/usr/bin/env bash

SCRIPT_ROOT=$( cd `dirname $0`; pwd)
source $SCRIPT_ROOT/.env

LEGO_CERT_DIR=$SCRIPT_ROOT/.lego/certificates/
CERT_DIR=$SCRIPT_ROOT/certificates
CERT_ARCHIVE=$SCRIPT_ROOT/certificates-${ROOT_DOMAIN}.tar.gz

set -e

lego \
  -a \
  --email ${CERT_EMAIL} \
  --dns route53 \
  -d ${ROOT_DOMAIN} \
  -d \*.${ROOT_DOMAIN} \
  run

[[ -d $CERT_DIR ]] || mkdir -p $CERT_DIR

cp -r $LEGO_CERT_DIR/${ROOT_DOMAIN}.*  $CERT_DIR

tar -czvf $CERT_ARCHIVE $CERT_DIR/${ROOT_DOMAIN}.*

echo "Email $CERT_ARCHIVE to client"
