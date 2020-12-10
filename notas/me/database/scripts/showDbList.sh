#!/bin/bash
PGUSER="postgres"
PGHOST=$PGHOST
export PGPASSWORD=$PGPASSWORD
export PGDATABASE=$PGUSER

while true ; do
  case "$1" in
    --host) shift; PGHOST=$1; shift;;
    --db) shift; PGDATABASE=$1; shift;;
    --user) shift; PGUSER=$1; shift;;
    --pass) shift; PGPASSWORD=$1; shift;;
    *) break;;
  esac
done

#echo params are $PGUSER $PGPASSWORD  $PGDATABASE
echo "[INFO] on host=$PGHOST on db=$PGDATABASE and user=$PGUSER"
echo "[INFO] on host=$PGHOST schemas"
psql  -U $PGUSER -c "\dn;"
echo "[INFO] on host=$PGHOST tables"
psql  -U $PGUSER -c "\dt;"
echo "[INFO] on host=$PGHOST views"
psql  -U $PGUSER -c "\dv;"
echo "[INFO] on host=$PGHOST materialized views"
psql  -U $PGUSER -c "\dm;"
echo "[INFO] on host=$PGHOST indexes"
psql  -U $PGUSER -c "\di;"
echo "[INFO] on host=$PGHOST sequences"
psql  -U $PGUSER -c "\ds;"
echo "[INFO] on host=$PGHOST foreign tables"
psql  -U $PGUSER -c "\dE;"


