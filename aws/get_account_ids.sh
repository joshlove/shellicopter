#!/usr/bin/env bash
source ./common.sh

for account in $(getProfiles); do
  echo "${account}:  $(aws --profile $account sts get-caller-identity --output text --query 'Account')"
done
