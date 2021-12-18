#!/bin/bash

for i in $(ls); do
echo "============================="
   if  file $i | grep -ivq encrypt; then
     echo "found: not encrypted file=$i";
     echo "info: $(file $i)";
     echo "Info: apply encryption: TODO";
     #todo 
   else
     echo "found: encrypted file=$i"
     echo "info: $(file $i)";
   fi
done;
