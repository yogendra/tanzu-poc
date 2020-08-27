#!/usr/bin/env bash
SCRIPT_ROOT=$( cd `dirname $0`; pwd)
echo "Read description in the $SCRIPT_ROOT/README.md"
read -p "Input [CLIENT]: " CLIENT
read -p "Input [JUMPBOX_IP]: " JUMPBOX_IP
read -p "Input [POC_DOMAIN]: " POC_DOMAIN
read -p "Input [AWS_HOSTED_ZONE_ID]: " AWS_HOSTED_ZONE_ID
read -p "Input [CERT_EMAIL]: " CERT_EMAIL

cat <<EOF  > $SCRIPT_ROOT/.env-private
CLIENT=$CLIENT
JUMPBOX_IP=$JUMPBOX_IP
POC_DOMAIN=$POC_DOMAIN
AWS_HOSTED_ZONE_ID=$AWS_HOSTED_ZONE_ID
CERT_EMAIL=$CERT_EMAIL
EOF

aws configure
