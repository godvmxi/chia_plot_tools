#!/bin/bash
cd  /srv/chia/tools/HPool-Miner-chia-v1.3.0-3
./hpool-miner-chia |tee /var/log/miner_chia.log
