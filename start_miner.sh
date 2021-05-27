#!/bin/bash
cd  /srv/chia/tools/HPool/v1.4.0-1/
./hpool-miner-chia |tee /var/log/miner_chia.log
