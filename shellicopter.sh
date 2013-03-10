#!/bin/bash

#shellicopter.sh - A collection of useful bash functions. Some of these are doable with normal bash operations/commands, but this can make 
#them somewhat easier to remember.

###ERROR HANDLING###
#Meant for functions in this script but can be used elsewhere

#chkRetcode - checks the returncode of the previous operation
#The first argument is what the function echos on success, the second on failure.
function chkRetcode(){
	retcode=$?
	success=$1
	failure=$2
	if [ $retcode == 0 ]; then
		echo "$success"
	else
		echo "$failure"
	fi
}
export chkRetcode


###ARRAY FUNCTIONS####
#contains - takes an array/string (haystack) and a search value (needle) and returns 1 if the item is within
function contains(){
	needle=$1
	haystack="$2"
	local value
	for value in "${haystack[*]}" do
		[[ $value == $needle ]] && return 1
	done

	return 0 #if it was present, 1 would have been returned earlier.
}
export contains

#arrayAppend - takes a string/array and appends it to another.
function arrayAppend(){

}
export arrayAppend

#arraySort - sorts an array
function arraySort(){

}
export arraySort

###DIRECTORY FUNCTIONS###

#mkcd - create a new directory, change into it immediately
function mkcd(){
	newdir=$1
	mkdir $newdir
	chkRetcode "Created $newdir" ""
}

#nemk - not exist make. Creates a directory if it doesn't exist 
function nemk(){
	newdir=$1

	if [ ! -d $newdir ]; then
		mkdir $newdir && cd $newdir
	fi
}

###DATES###

function datesBetween(){
	startdate=$1
	enddate=$2

	if [ $# != 2 ]; then
		echo "$0 requires two date parameters, each in yyyymmdd format"
		exit 1
	fi

	if  ! [[ $startdate =~ [0-9]{8} ]]; then
		echo "Startdate must be in yyyymmdd pattern (all digits)"
		exit 2
	fi

	if ! [[ $enddate =~ [0-9]{8} ]]; then
		echo "Enddate must be in yyyymmdd pattern (all digits)"
		exit 2
	fi

	dates=""
	loopdate=$startdate
	while [ "$loopdate != $enddate ]; do
		dates="${loopdate} ${dates}"
		loopdate=$(date +%Y%m%d -d "$loopdate + 1 day")
	done

	echo "${dates}"

}