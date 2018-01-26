#!/usr/bin/env bash
#note - brew install jq and parallel
echo "Going through profiles in ./aws/credentials..."
regions=($(getRegions))

function searchInstanceId {
  local account=$1
  local region=$2
  local id=$3

  output=$(aws ec2 describe-instances --region $region --profile $account  | jq "[.Reservations[] | .Instances[] | { InstanceID: .InstanceId, privIP: .PrivateIpAddress }]" | grep -B1 -A2 "$id")
  if [ "${output}" != "" ]; then
    echo "Account: $account Region: $region"
    echo "${output}"
    exit 0
  fi
}
export -f searchInstanceId

for account in $(grep '^\[' ~/.aws/credentials | sed -E -e 's/(\[|\])//g')
  do
  parallel "searchInstanceId $account {} $1" ::: "${regions[@]}"
done
