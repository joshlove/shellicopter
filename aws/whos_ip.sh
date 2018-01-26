#!/usr/bin/env bash
source ./common.sh

ip=$1
echo Getting list of IPs...

for account in $(getProfiles)
do
  echo $account
  aws ec2 describe-addresses --output table --profile $account | grep $ip
done
