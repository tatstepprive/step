#!/bin/bash
APPL=$1
SYNC_USER=
SYNC_SERVER=
while true ; do
  case "$1" in
    --appl) shift; APPL=$1; shift;;
    --user) shift; SYNC_USER=$1; shift;;
    --server) shift; SYNC_SERVER=$1; shift;;
    *) break;;
  esac
done

if [ "$APPL" = "" ]; then
  echo "ERROR: missing parameter, usage: sync_importer_multi --appl application"
  exit 1
fi

if [ "$SYNC_USER" = "" ]; then
  echo "ERROR: missing parameter, usage: sync_importer_multi --user user"
  exit 1
fi

if [ "$SYNC_SERVER" = "" ]; then
  echo "ERROR: missing parameter, usage: sync_importer_multi --server server"
  exit 1
fi
 
./sync_importer --appl $APPL --user $SYNC_USER --server $SYNC_SERVER --date-pattern $(date '+%Y%m%d') 
./sync_importer --appl $APPL --user $SYNC_USER --server $SYNC_SERVER --date-pattern $(date -d "1 day ago" '+%Y%m%d')  
./sync_importer --appl $APPL --user $SYNC_USER --server $SYNC_SERVER --date-pattern $(date -d "2 days ago" '+%Y%m%d') 
