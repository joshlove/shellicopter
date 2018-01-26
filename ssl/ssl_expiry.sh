#!/bin/bash
ERR=0

function ssl_check(){
local TARGET=$1;
local DAYS=7;
echo "checking if $TARGET expires in less than $DAYS days";
expirationdate=$(date -d "$(: | openssl s_client -connect $TARGET:443 -servername $TARGET 2>/dev/null \
                              | openssl x509 -text \
                              | grep 'Not After' \
                              |awk '{print $4,$5,$7}')" '+%s'); 
in7days=$(($(date +%s) + (86400*$DAYS)));
if [ $in7days -gt $expirationdate ]; then
    echo "KO - Certificate for $TARGET expires in less than $DAYS days, on $(date -d @$expirationdate '+%Y-%m-%d')"
    ERR="1"
else
    echo "OK - Certificate expires on $(date -d @$expirationdate '+%Y-%m-%d')"
fi;
}

ssl_check "domain1.com"

if [ $ERR -gt 0 ]; then
	exit 1
fi
