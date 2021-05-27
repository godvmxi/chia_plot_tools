## CHIA PLOT TOOLS
### NOTE:
1. Change your plot public key and farm pool key first in the chia_plot.sh first
2. Change your api key in HPool-Miner-chia/config.yaml, Do no attack me, just for fun
### Feature
> Support hpool tools
> Support chia cli tools
> Mine in hpool, default use the latest version, change a link when your want to use an older version
> Support each task temp and dst define
> Support chia cli temp2 define
> Add task start delay setting for muli-plot in small ssd, such as plot 2 in on 512GB SSD
> Use tmux to run the task
> Use sysstat, htop to monitor the system usage


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

### Auto Start plot when system boot

### Auto Start miner and monitor
Use supervisor will be a good choice, you can find my conf in the repo

