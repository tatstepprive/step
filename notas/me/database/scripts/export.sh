#!/bin/bash

##FROM DB
FROM_DB=$PGDATABASE
FROM_HOST=$PGHOST
FROM_PASS=$PGPASSWORD
PGUSER="postgres"
DUMP_DIR=/tmp/dumps

while true ; do
  case "$1" in
    --host) shift; FROM_DB=$1; shift;;
    --db) shift; FROM_DB=$1; shift;;
    --dr) shift; DUMP_DIR=$1; shift;;
    --user) shift; PGUSER=$1; shift;;
    --pass) shift; PGPASSWORD=$1; shift;;
    *) break;;
  esac
done

mkdir -p $DUMP_DIR
TIMESTAMP=$(date +%Y%m%d%Hu%Mm%Ss)
DUMP_FILE=${DUMP_DIR}/export_${FROM_DB}_${FROM_HOST}_${TIMESTAMP}.dump
LOG_FILE=${DUMP_DIR}/export_${FROM_DB}_${FROM_HOST}_${TIMESTAMP}.log

##Export data
echo "[INFO] Start export data from db=$FROM_DB on host host=$PGHOST"
PGPASSWORD=$FROM_PASS pg_dump -h $FROM_HOST -U $PGUSER --no-owner --no-acl -Fc -d $FROM_DB  -f $DUMP_FILE  --verbose 2>$LOG_FILE
echo "[INFO] End export data from db=$FROM_DB on host host=$PGHOST"
echo "[INFO] DUMP FILE: $(ls -lh $DUMP_FILE)"

