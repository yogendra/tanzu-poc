#!/bin/bash
eksctl create cluster \
  --name prod \
  --version 1.17 \
  --region ap-southeast-1 \
  --nodegroup-name linux-nodes \
  --node-type t3.medium \
  --nodes 3 \
  --nodes-min 1 \
  --nodes-max 4 \
  --ssh-access \
  --ssh-public-key ~/.ssh/id_rsa.pub \
  --managed
