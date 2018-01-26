#!/usr/bin/env bash
source ./common.sh

key=$1
echo Getting list of IAM Users...
for account in $(getProfiles); do
  aws iam list-users --profile $account | grep UserName | awk '{ print $2 }' | sed -e 's/"//g' | sed -e 's/,//g' > temp.users

  for user in `cat temp.users`; do
    aws iam --profile $account list-access-keys --user-name=$user | grep -B3 $key | grep UserName | awk '{ print $2 }' | sed -e 's/"//g' | sed -e 's/,//g'
  done
done
rm temp.users
