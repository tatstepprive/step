#!/bin/bash
APPL=$1
DATE_PATTERN=$(date '+%Y%m%d')
SYNC_USER=
SYNC_SERVER=
while true ; do
  case "$1" in
    --appl) shift; APPL=$1; shift;;
    --date-pattern) shift; DATE_PATTERN=$1; shift;;
    --user) shift; SYNC_USER=$1; shift;;
    --server) shift; SYNC_SERVER=$1; shift;;
    *) break;;
  esac
done

if [ "$APPL" = "" ]; then
  echo "ERROR: missing parameter, usage: sync_importer --appl application"
  exit 1
fi

if [ "$SYNC_USER" = "" ]; then
  echo "ERROR: missing parameter, usage: sync_importer --user user"
  exit 1
fi

if [ "$SYNC_SERVER" = "" ]; then
  echo "ERROR: missing parameter, usage: sync_importer --server server"
  exit 1
fi

DUMP_FILE=exp*${DATE_PATTERN}*.dump
LOCAL_PATH=/dumps/prd/$APPL/$DUMP_FILE

REMOTE_PATH=/home/$SYNC_USER
sftp -v $SYNC_USER@SYNC_SERVER <<EOF
put $LOCAL_PATH $REMOTE_PATH
EOF
