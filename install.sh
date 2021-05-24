#!/bin/bash
apt install tmux sysstat htop terminator supervisor
mkdir /etc/chia/ -p
cp cfg/*  /etc/chia/
cp supervisor/* /etc/supervisor/conf.d/
mkdir -p /var/log/chia/
chmod 666 /var/log/chia