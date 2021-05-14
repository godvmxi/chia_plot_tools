#!/bin/bash
TMP_DIR=/srv/chia/vg
DST_DIR=/srv/chia/disk
TASK_NUM=1
SESSION=CHIA

function show_help()
{
    echo -e "Usage : "
    echo -e "\t./run.sh  job_number"
    echo -e "\n"
}
function run_tmux_plot_cmd()
{
    ID=$1
    T_DIR=$2
    D_DIR=$3
    mkdir -p ${T_DIR} ${D_DIR}
    DELAY=0
    let DELAY=${ID}-1
    let DELAY=${DELAY}*300
    rm -rf ${T_DIR}/*
    echo "delay to start: "$DELAY
    tmux new-window -t ${SESSION}:${ID} -n ${SESSION}:${ID}
    TASK_INFO="TASK:\n\tID:"${ID}"\n\tTMP: "${T_DIR}"\n\tDST: "${D_DIR}
    echo -e ${TASK_INFO}

    tmux send-keys -t ${SESSION} "echo -e ${TASK_INFO}"  C-m
    tmux send-keys -t ${SESSION} "cd /nfs/chia/chia-plotter/" C-m
    tmux send-keys -t ${SESSION} "sleep ${DELAY};time ./chia-plotter-linux-amd64 -action plotting -plotting-fpk 0x8addc65c5cc57e2ea08c460d15a2287143fff3c357b9f554b0a831a7722acea624532aab7fb488c3f0d7a35a71809496 -plotting-ppk 0xa605b02dc7ebd75712a50d650a5aa708cd5e98a05ae0f5a1c9364cd2569a717b3f4c5457d929259649af7335b66c00c9 -plotting-n 10 -b 3380 -r 2 -p  -d ${D_DIR} -t ${T_DIR} " C-m
    #time ./chia-plotter-linux-amd64 -action plotting -plotting-fpk 0x8addc65c5cc57e2ea08c460d15a2287143fff3c357b9f
    cd -
    return 0
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


}

if [ $# -lt 1 ]; then
    show_help 
    exit 0
fi
TASK_NUM=$1
echo -e "Run Task Number: " $TASK_NUM
echo -e "TMP DIR -> "$TMP_DIR
echo -e "DST DIR -> "$DST_DIR
#terminator -e 'tmux'
tmux has-session -t $SESSION  2> /dev/null
if [ $? != 0  ] ; then
    echo "No exist session, create a new one"
else
    echo "Find exist session, destory and create a new one"
    tmux kill-session -t $SESSION
fi
tmux new-session -A -d -s ${SESSION}
terminator -m -e "tmux a -t ${SESSION}"
tmux send-keys -t ${SESSION} 'htop'   C-m
tmux rename-window -t 0 "TASK:"${TASK_NUM}
let n=1
while [ $n -le $TASK_NUM  ]
do
    echo "loop -> $n"
    echo "clean tmp dir -> ${TMP_DIR}"
    run_tmux_plot_cmd ${n} ${TMP_DIR}/tmp_$n ${DST_DIR}/$n/chia

    #

    let n++
done




