#!/bin/bash

df -k | grep -v proc | grep -v Filesystem | grep -v mapper | grep -v tmpfs | grep -v loop | grep -v : | sed -f work_scripts/concat_space > /tmp/filesystem
cat /tmp/filesystem | while read line
do
   sizePerc=$(echo $line | grep -o [0-9]*% )
   size=$(echo $sizePerc |sed s/%//g )
   if [ $size -ge 60 ]
   then
      filet=$(echo $line | cut -f6 -d " ")
      echo "[WARNING] Filesystem $filet filled at $sizePerc"
   fi
done
