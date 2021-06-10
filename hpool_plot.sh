#!/bin/bash
CFG_FILE=/etc/chia/hpool.conf

SESSION=CHIA
#REPLACE the key to yours
PUBLIC_KEY=8addc65c5cc57e2ea08c460d15a2287143fff3c357b9f554b0a831a7722acea624532aab7fb488c3f0d7a35a71809496
POOL_KEY=a605b02dc7ebd75712a50d650a5aa708cd5e98a05ae0f5a1c9364cd2569a717b3f4c5457d929259649af7335b66c00c9

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
   
   tmux send-keys -t ${SESSION} 'chia keys show'   C-m
   tmux splitw  -v -p 90 -t ${SESSION}
   tmux send-keys -t ${SESSION} 'htop'   C-m
   tmux splitw  -h -p 50 -t ${SESSION}
   tmux send-keys -t ${SESSION} 'watch "sensors;iostat -h"'   C-m
   tmux rename-window -t 0 "CHIA:0"

#   terminator -m -e "tmux a -t ${SESSION}"
}

function run_tmux_plot_cmd()
{
    ID=$1
    NAME=${2^^}
    DELAY=$3
    T_DIR=$4/tmp
    T2_DIR=$5/tmp
    D_DIR=$6/chia
    MEM_SIZE=$7
    THREAD_NUM=$8

    TASK_INFO="TASK: ID:${ID} NAME: ${NAME} \tTMP: ${T_DIR}\t T2:${T2_DIR}\t DST: ${D_DIR} DELAY:${DELAY}\t MEM:${MEM_SIZE} THREAD:${THREAD_NUM}"
    echo -e "RUN : ${TASK_INFO}"

    mkdir -p ${T_DIR}
    mkdir -p ${T2_DIR}
    mkdir -p ${D_DIR}    
    rm -rf ${T_DIR}/*
    rm -rf ${T2_DIR}/*
    let DELAY_MS=${DELAY}*60
    #echo "delay to start->min: $DELAY ms: $DELAY_MS"
    tmux new-window -t ${SESSION}:${ID} -n ${SESSION}:${ID}
    
    tmux send-keys -t ${SESSION} "time sleep ${DELAY_MS} ;cd /srv/chia/tools/chia-plotter;./chia-plotter-linux-amd64 -action plotting -plotting-fpk 0x${PUBLIC_KEY}  -plotting-ppk 0x${POOL_KEY}  -plotting-n 1000 -b ${MEM_SIZE} -r ${THREAD_NUM} -p  -d ${D_DIR} -t ${T_DIR}" C-m

    #tmux send-keys -t ${SESSION} "sleep ${DELAY_MS};time chia plots create -k 32 -f ${PUBLIC_KEY} -p ${POOL_KEY}  -b ${MEM_SIZE} -r ${THREAD_NUM} -n 10000 -t ${T_DIR} -2 ${T2_DIR} -d ${D_DIR}" C-m
    tmux rename-window -t ${SESSION}  "${ID}-${NAME}"
    #time ./chia-plotter-linux-amd64 -action plotting -plotting-fpk 0x8addc65c5cc57e2ea08c460d15a2287143fff3c357b9f



}


show_help
if [ $# -eq 2 ]; then
   echo "read extra cfg file from cmd"
   CFG_FILE=$2
elif [ $# -eq 1 ]; then
      echo "read extra cfg file from cmd"
fi



echo "Para Num -> "$#
echo "CFG FILE -> "$CFG_FILE
init_tmux_session
let INDEX=1
while read LINE;
do
   #declare "$LINE";
   #echo "$LINE";
   if [ x${LINE:0:1} == "x#"  ] ; then
       #echo "Comment line"
       continue


   else
       NAME=`echo ${LINE}   |awk '{print $1}'`
       T_DIR=`echo ${LINE}  |awk '{print $2}'`
       T2_DIR=`echo ${LINE} |awk '{print $3}'`
       D_DIR=`echo ${LINE}  |awk '{print $4}'`
       DELAY=`echo ${LINE}  |awk '{print $5}'`
       MEM_SIZE=`echo ${LINE} |awk '{print $6}'`
       THREAD_NUM=`echo ${LINE} |awk '{print $7}'`
       if [ "x${DELAY}" == "x" ]; then
           DELAY=0
       fi 
       if [ "x${MEM_SIZE}" == "x" ]; then
          MEM_SIZE=4000
       fi 
       if [ "x${THREAD_NUM}" == "x" ]; then
          THREAD_NUM=2
       fi 
       #echo -e "INDEX->${INDEX} NAME->${NAME} DELAY->${DELAY} Tmp->  ${T_DIR} TMP2->${T2_DIR}  Dst-> ${D_DIR}  Mem->${MEM_SIZE}  Thread->${THREAD_NUM} "
       run_tmux_plot_cmd  ${INDEX} ${NAME} ${DELAY}  ${T_DIR} ${T2_DIR} ${D_DIR} ${MEM_SIZE} ${THREAD_NUM}
       sleep 2
       let INDEX++
   fi
done < ${CFG_FILE}


tmux select-window -t ${SESSION}:0
tmux rename-window -t 0 "CHIA:${INDEX}"




