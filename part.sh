#!/bin/bash
echo "will part disk -> "$1
sleep 3
parted $1  unit s  mklabel gpt
parted $1  mkpart primary ext4  2048  409599
parted $1  mkpart primary ext4  409600 100%
fdisk -l $1
mkfs.ext4 ${1}1
mkfs.ext4 ${1}2
