#!/bin/bash
COUNT=$1
CWD=`dirname $0`
DST=/srv/chia/disk/00
echo $CWD
RAM_DIR=/srv/chia/cache/ram/00
#cd $SDIR
pwd
trap 'onCtrlC' INT

function onCtrlC () {
	echo 'Ctrl+C is captured'
	tree ${DST}
	tree ${SDST}
	exit 0
}


for i in `(seq 1 ${COUNT} )`
do
	echo
	echo
	echo "Start the file -> "$i"##############################"
	date
	rm -rf ${RAM_DIR}/*  ${DST}/tmp/*
	mkdir -p  ${RAM_DIR}  ${DST}/tmp/ ${DST}/dst/
	#exit 0
	time ${CWD}/chia-plotter-ram  -r 18 -t ${DST}/tmp/ -2 ${RAM_DIR}/   -d ${DST}/dst/  -c xch1upd5ea9rcycpmaynj0sy34v53xjqwhy603yz24pms79thhcfnu8qtwap3x  -f 92375c767ac2138be741227023284e330c6bb7b7d8b0cacc170e5ce1ed19f064e672136d33e841ddafc7713c88a82e73
	echo "Finsh the file -> "$i"-----------------------------"
	date
	echo
	echo
	echo
	echo
done
rm -rf ${TPD}
#rsync  -P --size-only --remove-source-files  dst/*  jbright@jbright-ws:/srv/chia/dst/99/
#$rm -rf ${TPD}
exit 0

