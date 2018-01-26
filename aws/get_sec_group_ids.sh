#!/usr/bin/env bash
if [ $# -eq 0 ]
  then
    echo "requires profile name as only arg"
fi
aws ec2 --profile $1 describe-security-groups --output text --query 'SecurityGroups[*].[GroupId]'
