#!/usr/bin/env bash
source ./common.sh

for account in $(getProfiles); do
  echo ${account}:
	for region in $(getRegions); do
		output=$(aws ec2 --region $region --profile $account --output text describe-addresses | grep ADDRESSES | grep eipassoc | awk -F"\t" '{if ($3)print $9}')
		if [ "$output" != "" ]; then
			echo -e "${BOLD}${GREEN} $region ${NC}${NORMAL}"
			echo "${output}"
		fi
  done
	echo -e "\n"
done
