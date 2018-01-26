#!/usr/bin/env bash
source common.sh

for account in $(getProfiles); do
 aws ec2 --profile $account describe-security-groups --output text
done
