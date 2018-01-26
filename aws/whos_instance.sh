#!/usr/bin/env bash
source ./common.sh
instanceId=$1

echo Getting list of IPs...
for account in $(getProfiles)
do
  echo $account
  aws ec2 describe-instances --output table --profile $account | grep $instanceId | grep HostName | awk '{ print $4 }'
done
