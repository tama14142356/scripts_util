#!/bin/bash
#引数の数だけループさせる
while true
do
  sleep 10
  # date_str=$(date)
  # echo "$date_str"
  qstat
done
# for i in $(seq 1 ${#}); do
#     echo 'looping: '
#     echo "$i"
#     echo "${1}" #第一引数を表示
#     shift       #shift
# done
# background_process=$(ps axo user,pid,args | grep "$1" | grep -v grep | grep -v bash | awk '{print $2}')
# set -f -- "$background_process"
# #引数の数だけループさせる
# for i in $(seq 1 ${#}); do
#     echo "$i"
#     echo "${1}" #第一引数を表示
#     echo 'kill process: '
#     # ps o user,pid,args --pid "${1}"
#     # kill "${1}"
#     shift #shift
# done

# gpus=10
# tmp=""
# for i in $(seq 1 ${gpus}); do
#     ii=$(($i-1))
#     tmp+="$ii"
#     if [ $i -lt $gpus ];then
#         tmp+=","
#     fi
# done
# echo "$tmp"

