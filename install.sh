#!/bin/bash
apt install tmux sysstat htop terminator supervisor lm-sensors
mkdir /etc/chia/ -p
cp cfg/*  /etc/chia/
cp supervisor/* /etc/supervisor/conf.d/
mkdir -p /var/log/chia/
chmod 666 /var/log/chia
ln -sfv /usr/lib/chia-blockchain/resources/app.asar.unpacked/daemon/chia  /usr/bin/chia
