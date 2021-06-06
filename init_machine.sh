#!/bin/bash
base=/srv/chia
function create_seq_dir()
{
   for i in $(seq 1 $1);
   do
      dir=$(printf "%02d" $i)
    #echo "dir name ->"${dir}
      mkdir -pv ${dir}
   done
}

mkdir -pv ${base}; cd ${base}
mkdir -pv disk dst cache link
cd ${base}/disk
create_seq_dir  12
#make cache
cd ${base}/cache
mkdir -pv ssata;cd ssata
create_seq_dir  5
cd ${base}/cache
mkdir -pv nvme;cd nvme
create_seq_dir  5
cd ${base}/cache
mkdir -pv hdd;cd hdd
create_seq_dir  10
cd ${base}/cache
mkdir -pv vg;cd vg
create_seq_dir  3
tree ${base}
chown jbright:jbright -R ${base}
#make log
mkdir -pv /var/log/chia/
chmod 777 /var/log/chia/
mkdir -pv /etc/chia/
chmod 777 /etc/chia/
#make

