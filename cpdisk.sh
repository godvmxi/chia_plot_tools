#!/bin/bash

CWD=`dirname $0`
echo $CWD
SDIR=`pwd`/${CWD}
echo ${SDIR}
target=$1

while (( 0 != 1 ))
do
	find /srv/chia/disk/00 -name "*.plot" |xargs -i rsync  -P --size-only --remove-source-files  {}   $target
	#echo "sleep 2 minutes"
	sleep 300
done
