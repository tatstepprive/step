#!/bin/bash
FILE=userlist.txt
CODED=$(echo -n $SECRET | md5sum | awk '{print $1}')
echo \"$NEWUSER\" \"$CODED\" >> $FILE
CODED_RO=$(echo -n $SECRET_RO | md5sum | awk '{print $1}')
echo \"$NEWUSER_RO\" \"$CODED_RO\" >> $FILE
echo "See file=$FILE for the md5 secret encoding in your current directory"

