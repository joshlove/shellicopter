#!/usr/bin/env bash
#useful from a jumphost to list all the boxes and their IP.
 
jl_region=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}')
alias boxes="aws ec2 --region ${jl_region} describe-instances --filters --query 'Reservations[].Instances[].[PrivateIpAddress,InstanceId,Tags[?Key=='Name'].Value[]]' --output text | sed 's/None$/None\n/' | sed '$!N;s/\n/ /'"
