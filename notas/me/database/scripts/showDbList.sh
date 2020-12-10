#!/bin/bash
PGUSER=${1:-"postgres"}
export PGPASSWORD=${2:-"$PGPASSWORD"}
export PGDATABASE=${3:-"$PGUSER"}
#echo params are $PGUSER $PGPASSWORD  $PGDATABASE
echo "[INFO] on host=$PGHOST"
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


