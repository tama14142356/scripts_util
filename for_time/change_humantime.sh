#!/bin/bash

tar_time=$1
minutes=$(($tar_time / 60))
# echo "$minutes m"
seconds=$(($tar_time - ($minutes * 60)))
# echo "$seconds s"
hours=$(($minutes / 60))
# echo "$hours h"
minutes=$(($minutes - $hours * 60))
# echo "$minutes m"

echo "$hours h $minutes m $seconds s"
