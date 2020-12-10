#!/bin/bash
PGUSER=${1:-"postgres"}

psql -U $PGUSER -c "SELECT (pg_stat_file('base/'||oid ||'/PG_VERSION')).modification, datname FROM pg_database;"
