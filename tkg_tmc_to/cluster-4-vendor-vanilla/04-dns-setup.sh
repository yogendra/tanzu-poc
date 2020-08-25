#!/bin/bash


HOSTED_ZONE=Z05688932VSDMPEHGAGKB
LB=$(kubectl get svc -n tanzu-system-ingress envoy  -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
cat <<EOF > 04-dns.json
{
  "Comment": "Updating poc.yogendra.me",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "cluster-4.poc.yogendra.me",
        "Type": "CNAME",
        "TTL": 60,
        "ResourceRecords": [
          {
            "Value": "$LB"
          }
        ]
      }
    }
  ]
}
EOF

aws route53 change-resource-record-sets --hosted-zone-id=$HOSTED_ZONE --change-batch file://04-dns.json

