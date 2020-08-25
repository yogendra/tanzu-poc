#!/usr/bin/env bash

SCRIPT_ROOT=$( cd `dirname $0`; pwd)
source $SCRIPT_ROOT/.env

set -e 

cat <<EOF > dns.json
{
  "Comment": "Updating ${LOCAL_REGISTRY} to ${JUMPBOX_IP}",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "${LOCAL_REGISTRY}",
        "Type": "A",
        "TTL": 10,
        "ResourceRecords": [
          {
            "Value": "${JUMPBOX_IP}"
          }
        ]
      }
    }
  ]
}
EOF

aws route53 change-resource-record-sets --hosted-zone-id=${AWS_HOSTED_ZONE_ID} --change-batch file://dns.json

rm dns.json
