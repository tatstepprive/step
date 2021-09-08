#!/bin/bash

MY_TABLE_CSV_FILE=$1

if [[ "$MY_TABLE_CSV_FILE" == "" ]]; then
  echo "CSV file with my_table data is required"
  exit 1
fi

loaderCtlFile=/tmp/loader-$RANDOM.ctl

echo "Loading my_table $MY_TABLE_CSV_FILE"

echo "load data CHARACTERSET WE8ISO8859P1" >> $loaderCtlFile 
echo "infile '$MY_TABLE_CSV_FILE'" >> $loaderCtlFile
echo "TRUNCATE" >> $loaderCtlFile
echo "into table my_table" >> $loaderCtlFile
echo "fields terminated by \";\"" >> $loaderCtlFile
echo "(my_id,my_dept)" >> $loaderCtlFile

sqlldr $DB_USERNAME/$DB_PASSWORD@$DB_SID control=$loaderCtlFile

rm $loaderCtlFile

