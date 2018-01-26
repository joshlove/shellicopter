#!/usr/bin/env bash
source ./common.sh
echo Getting count of instances...

total=0
for account in $(getProfiles); do
	echo $account
	count=$(aws ec2 describe-instances --profile $account | grep InstanceId | wc -l)
	echo "$count"
	total=$(bc <<< "$total + $count")
done

echo -e "${BOLD}Total: ${GREEN}${total}${NC}${NORMAL}"
