#!/usr/bin/env bash
source ./common.sh
echo ${BOLD}Getting list of instances...${NORMAL}
touch instance_sizes.temp

for account in $(getProfiles); do
  echo -e ${BGBLUE}${account}${NC}
  aws ec2 describe-instances --profile $account | grep InstanceType | sed -e 's/"/ /g' | awk '{ print $3 }' | sort | uniq -c | tee -a "instance_sizes.temp"
done

echo -e ${BLUE}${BOLD}Total from all accounts by instance size:${NORMAL}${NC}
cat instance_sizes.temp | sort | awk '{a[$2]+=$1}END{for(i in a) print i,a[i]}'

echo -e ${RED}${BOLD}GRAND TOTAL:${NORMAL}${NC}
cat instance_sizes.temp | awk '{ print $1 }' | paste -sd+ - | bc

# Clean up
rm instance_sizes.temp
