#!/usr/bin/env bash
source ./common.sh
echo Getting list of Instances and EIPs...

for account in $(getProfiles)
do
	echo -e "${BOLD}${GREEN}${account}${NC}${NORMAL}"
	aws ec2 --profile $account describe-addresses --output text | grep ADDRESSES | grep eipassoc | awk -F"\t" '{if ($5)print $5, $9}'
	echo ""
done
