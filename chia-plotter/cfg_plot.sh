#!/bin/bash
CFG_FILE=/etc/chia/plot.conf

TASK_NUM=1
SESSION=CHIA

function show_help()
{
    echo -e "Usage : "
    echo -e "\t./run.sh   [cfg_file]"
    echo -e "\n"
}
function init_tmux_session()
{
   tmux has-session -t $SESSION  2> /dev/null
   if [ $? != 0  ] ; then
      echo "No exist session, create a new one"
   else
      echo "Find exist session, destory and create a new one"
      tmux kill-session -t $SESSION
   fi
   tmux new-session -A -d -s ${SESSION}
   
   tmux send-keys -t ${SESSION} 'htop'   C-m
   tmux splitw  -h -p 50 -t ${SESSION}
   tmux send-keys -t ${SESSION} 'watch "iostat -h"'   C-m
   tmux rename-window -t 0 "TASK:"${TASK_NUM}

   terminator -m -e "tmux a -t ${SESSION}"
}

function run_tmux_plot_cmd()
{
    ID=$1
    DELAY=$2
    T_DIR=$3
    D_DIR=$4
    MEM_SIZE=$5
    THREAD_NUM=$6
    
    mkdir -p ${T_DIR} ${D_DIR}
    let DELAY_MS=${DELAY}*60
    rm -rf ${T_DIR}/*
    #echo "delay to start->min: $DELAY ms: $DELAY_MS"
    tmux new-window -t ${SESSION}:${ID} -n ${SESSION}:${ID}
    TASK_INFO="TASK: ID:"${ID}" TMP: "${T_DIR}"  DST: "${D_DIR}
    echo -e ${TASK_INFO}

    tmux send-keys -t ${SESSION} "echo INDEX:${INDEX} ${TASK_INFO} DELAY: ${DELAY_MS} TMP:${T_DIR} DST:${D_DIR} MEM:${MEM_SIZE} THREAD_NUM:${THREAD_NUM}"  C-m
    tmux send-keys -t ${SESSION} "cd /srv/chia/tools/chia-plotter/" C-m
    tmux send-keys -t ${SESSION} "sleep ${DELAY_MS};time ./chia-plotter-linux-amd64 -action plotting -plotting-fpk 0x8addc65c5cc57e2ea08c460d15a2287143fff3c357b9f554b0a831a7722acea624532aab7fb488c3f0d7a35a71809496 -plotting-ppk 0xa605b02dc7ebd75712a50d650a5aa708cd5e98a05ae0f5a1c9364cd2569a717b3f4c5457d929259649af7335b66c00c9 -plotting-n 1000 -b ${MEM_SIZE} -r ${THREAD_NUM} -p  -d ${D_DIR} -t ${T_DIR} " C-m
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


show_help
if [ $# -eq 2 ]; then
   echo "read extra cfg file from cmd"
   CFG_FILE=$2
elif [ $# -eq 1 ]; then
      echo "read extra cfg file from cmd"
      TASK_NUM=$1    
fi



echo "Para Num -> "$#
echo "CFG FILE -> "$CFG_FILE
init_tmux_session
let INDEX=1
while read LINE;
do
   #declare "$LINE";
   #echo "$LINE";
   INFO=`echo ${LINE} |awk '{print $1}'`
   T_DIR=`echo ${LINE} |awk '{print $2}'`
   D_DIR=`echo ${LINE} |awk '{print $3}'`
   DELAY=`echo ${LINE} |awk '{print $4}'`
   MEM_SIZE=`echo ${LINE} |awk '{print $5}'`
   THREAD_NUM=`echo ${LINE} |awk '{print $6}'`
   if [ "x${DELAY}" == "x" ]; then
      DELAY=0
   fi 
   if [ "x${MEM_SIZE}" == "x" ]; then
      MEM_SIZE=3880
   fi 
   if [ "x${THREAD_NUM}" == "x" ]; then
      THREAD_NUM=2
   fi 
   echo -e "INDEX->${INDEX} INFO->${INFO} DELAY->${DELAY} Tmp->  ${T_DIR}  Dst-> ${D_DIR}  Mem->${MEM_SIZE}  Thread->${THREAD_NUM} "

   run_tmux_plot_cmd ${INDEX} ${DELAY}  ${T_DIR} ${D_DIR} ${MEM_SIZE} ${THREAD_NUM}
   let INDEX++
done < ${CFG_FILE}

for i in `seq 1 ${index}`
do
    tmux select-window -t ${SESSION}:i
    sleep 3
done

tmux select-window -t ${SESSION}:0




