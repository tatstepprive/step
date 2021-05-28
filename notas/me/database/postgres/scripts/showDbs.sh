#!/bin/bash
MY_USER=${1:-"postgres"}
PGUSER=${2:-"postgres"}
echo "[INFO] on host=$PGHOST databases"
psql -U $PGUSER -c "SELECT datname,encoding,datacl FROM pg_database order by datname;"
