#!/bin/bash
cat <<EOF
CLUSTER_VPC="vpc-06ebf8deda2e5dbc4"
CLUSTER_UUID="$(tmc cluster get cluster-1 | yq r -  "objectMeta.parentReferences[0].uid.value" | cut -c4- |  tr '[:upper:]' '[:lower:]')"

echo -e "\n${green}Fetching public subnets from vpc $CLUSTER_VPC ${reset}"
subnets=( $(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$CLUSTER_VPC" \
"Name=tag:Name,Values=SubnetAZ?Public" --query 'Subnets[*].[SubnetId]' --output text) )

echo -e "\n${green}Adding kubernetes tags to public subnets for LoadBalancer type service"
SUBNETS=""
for subnet in "${subnets[@]}"
do
aws ec2 create-tags --resources "$subnet" --tags Key="kubernetes.io/cluster/$CLUSTER_UUID",Value="shared"
SUBNETS="$subnet "
done


EOF
pause
