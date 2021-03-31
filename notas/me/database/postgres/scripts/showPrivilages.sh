#!/bin/bash
MY_USER=${1:-"postgres"}
PGUSER=${2:-"postgres"}
echo "[INFO] on host=$PGHOST privileges for user=$MY_USER"
psql -U $PGUSER -c "SELECT table_catalog, table_schema, table_name, privilege_type
FROM   information_schema.table_privileges 
WHERE  grantee = '"$MY_USER"';"
