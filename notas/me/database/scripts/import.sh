#!/bin/bash

##TARGET DB
TARGET_DB=$PGDATABASE
TARGET_HOST=$PGHOST
TARGET_USER=$PGUSER
TARGET_PASS=$PGPASSWORD
DUMP_DIR=/tmp/dumps
DUMP_FILE=$1

while true ; do
  case "$1" in
    --host) shift; TARGET_DB=$1; shift;;
    --db) shift; TARGET_DB=$1; shift;;
    --dr) shift; DUMP_DIR=$1; shift;;
    --user) shift; TARGET_USER=$1; shift;;
    --pass) shift; TARGET_PASS=$1; shift;;
    *) break;;
  esac
done

mkdir -p $DUMP_DIR
TIMESTAMP=$(date +%Y%m%d%Hu%Mm%Ss)
LOG_FILE=${DUMP_DIR}/import_${TARGET_DB}_${TARGET_HOST}_${TIMESTAMP}.log

##Export data
echo "[INFO] Start import data to db=$TARGET_DB on host host=$PGHOST"
PGPASSWORD=$TARGET_PASS pg_dump -h $TARGET_HOST -U $PGUSER --no-owner --no-acl -Fc -d $TARGET_DB  -f $DUMP_FILE  --verbose 2>$LOG_FILE
PGPASSWORD=$TARGET_PASS pg_restore -Fc -O -h $TARGET_HOST -U $TARGET_USER -d $TARGET_DB -v $DUMP_FILE
echo "[INFO] End import data to db=$TARGET_DB on host host=$TARGET_HOST with dump=$DUMP_FILE"

