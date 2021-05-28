#!/bin/bash
MY_TABLE=${1:-"pg_database"}
PGUSER=${2:-"postgres"}
echo "[INFO] on host=$PGHOST describe table=$MY_TABLE"

psql -U $PGUSER -c "SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
   table_name = '"$MY_TABLE"';"
