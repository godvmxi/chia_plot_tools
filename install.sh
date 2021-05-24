#!/bin/bash
apt install tmux sysstat htop terminator
mkdir /etc/chia/ -p
cp chia.conf  /etc/chia/
cp hpool.conf /etc/chia/
