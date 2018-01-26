#!/usr/bin/env bash
source ./common.sh
profile=$1

for region in $(getRegions); do
  echo "$region"
  aws ec2 --region $region \
  --profile $profile \
  --output text describe-addresses \
  | grep ADDRESSES \
  | grep eipassoc \
  | awk -F"\t" '{if ($3)print $8, $9}'
done
