#!/usr/bin/env bash
getProfiles() {
  grep '^\[' ~/.aws/credentials | sed -E -e 's/(\[|\])//g'
}
export -f getProfiles

#Uses the first match from getProfiles to query global ec2 regions
getRegions() {
  aws ec2 --profile $(getProfiles | grep -m1 '.*') describe-regions | \
  jq '[.Regions[] | {reg: .RegionName}]' | \
  grep reg | cut -d " " -f6 | sed -e 's/"//g'
}
export -f getRegions

export BOLD=$(tput bold)
export NORMAL=$(tput sgr0)
export RED='\033[0;31m'
export BLUE='\033[0;34m'
export GREEN='\033[0;32m'
export BGBLUE='\033[34;47m'
export NC='\033[0m' # No Color
