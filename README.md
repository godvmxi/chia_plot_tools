## CHIA PLOT TOOLS
### NOTE:
1. Change your plot public key and farm pool key first in the chia_plot.sh first
2. change your api key in HPool-Miner-chia/config.yaml, Do no attack me, just for fun
### Feature
> support hpool tools
> support chia cli tools
> support each task temp and dst define
> support chia cli temp2 define
> add task start delay setting for muli-plot in small ssd, such as plot 2 in on 512GB SSD
> use tmux to run the task
> use sysstat, htop to monitor the system usage


### Config your file
if you want to use the origin chia cli tools, just modify the chia.conf, it will be installed to /etc/chia/
otherwise, use the hpool.conf
### Install
sudo ./install.sh 

### Run
choose one:
> ./chai_plot.sh
> ./hpool_plot.sh

### Request
If you need windows or GUI support, fire a issue, if there are many request, I will consider to develop it.
