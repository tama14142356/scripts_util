#!/bin/bash
# set -eux
# n_file=${1:-"2"}
files="${@:-"tmp1.pdf tmp2.pdf output.pdf"}"
input_files=""
output_file_name=""
n_files=0
for f in ${files}
do
    n_files=$(($n_files+1))
done
i=0
for f in ${files}
do
    i=$(($i+1))
    if [ $i -lt $n_files ];then
        input_files+="$f"
    else
        output_file_name="$f"
    fi
    if [ $i -lt $n_files ];then
        input_files+=" "
    fi
done
# echo "$input_files"
# echo "$output_file_name"
pdftk $input_files cat output "$output_file_name"
