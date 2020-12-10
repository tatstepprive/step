#!/bin/bash

##FROM DB
FROM_PASS=
FROM_DB=
FROM_HOST=
TIMESTAMP=$(date +%Y%m%d%Hu%Mm%Ss)
DUMP_FILE=./dumps/export_${FROM_DB}_${FROM_HOST}_${TIMESTAMP}.dump
LOG_FILE=./dumps/export_${FROM_DB}_${FROM_HOST}_${TIMESTAMP}.log

export PGPASSWORD=$FROM_PASS

##Export data
echo "Start export data from db=$FROM_DB"
PGPASSWORD=$FROM_PASS pg_dump -h $FROM_HOST -U postgres --no-owner --no-acl -Fc -d $FROM_DB  -f $DUMP_FILE  --verbose 2>$LOG_FILE

