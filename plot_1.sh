#!/bin/bash
TMP_DIR=/nfs/chia/ssd/tmp
DST_DIR=/nfs/work/chia/dst/
mkdir ${TMP_DIR}
#rm -rf ${TMP_DIR}/*
function chia_plotter()
{
    cd /nfs/chia/chia-plotter/
    time ./chia-plotter-linux-amd64 -action plotting -plotting-fpk 0x8addc65c5cc57e2ea08c460d15a2287143fff3c357b9f554b0a831a7722acea624532aab7fb488c3f0d7a35a71809496 -plotting-ppk 0xa605b02dc7ebd75712a50d650a5aa708cd5e98a05ae0f5a1c9364cd2569a717b3f4c5457d929259649af7335b66c00c9 -plotting-n 1 -b 6000 -r 4 -p  -d $1 -t $2
    echo
echo
echo
echo  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  "++++++++++++++++++++++++++  Plot Done  ++++++++++++++++++++++++++++++++"
echo  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
echo
echo
}

let n=1
LOOP=10
while [ $n -le  $LOOP ]
do
    echo "loop -> $n"
    echo "clean tmp dir -> ${TMP_DIR}"
    rm -rf ${TMP_DIR}/*
    echo "plot info tmp-> ${TMP_DIR}"
    echo "plot info dst-> ${DST_DIR}"
    sleep 4
    chia_plotter ${DST_DIR}  ${TMP_DIR}
    let n++
done
