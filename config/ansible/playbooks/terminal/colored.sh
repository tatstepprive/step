#!/bin/bash
#check if filetype is text file, if yes show content in color
fileType="$(file "$1" | grep -o 'text')"
if [ "$fileType" == 'text' ]; then
#    echo -en "\033[1m"
    echo -en '\033[01;32m'
else
#    echo -en "\033[31m"
    echo -en '\033[01;31m'
fi
cat $1
echo -en "\033[0m"
