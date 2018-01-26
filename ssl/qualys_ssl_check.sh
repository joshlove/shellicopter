#!/usr/bin/env bash +x
# needs go

#clone the repo if it's not there.
if [ ! -d ssllabs-scan ]; then
    ssh-keyscan -H github.com >> ~/.ssh/known_hosts
	git clone git://github.com/ssllabs/ssllabs-scan.git
fi
	
#jump into it
cd ssllabs-scan

#check if we have a built binary
if [ ! -f ssllabs-scan ]; then
	go build ssllabs-scan.go
fi

function scan(){
  result=$(./ssllabs-scan --quiet --grade $1)
  if ! [[ "${result}" =~ "A" ]]; then
    echo "$1 did not receive an A rating"
    return 1
  else
    return 0
  fi
}

status=0
for i in domain1.com domain2.com
do
  scan $i || status=1
done

if [ $status == 1 ]; then
  exit 1
fi

exit 0
