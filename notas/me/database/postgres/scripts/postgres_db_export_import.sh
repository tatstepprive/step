#!/bin/bash

##FROM LOCAL
FROM_PASS=postgres
FROM_HOST="localhost"
FROM_DB="fromDb"

##TO LOCAL
TARGET_PASS=postgres
TARGET_HOST="localhost"
TARGET_DB="toDB"
TARGET_OWNER="target_owner"
TARGET_OWNER_PASS='target_owner_pass'

##ON TARGET DB ==========================================================
export PGPASSWORD=$TARGET_PASS

##Drop DB is exist
if psql -h $TARGET_HOST  -U "postgres" -lqt | cut -d \| -f 1 | grep -qw $TARGET_DB ; then
    echo "Drop connections on db=$TARGET_DB on host=$TARGET_HOST"
    psql -h $TARGET_HOST  -U "postgres" -d $TARGET_DB -c "SELECT pid, pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = current_database() AND pid <> pg_backend_pid();";
    echo "Drop database db=$TARGET_DB on host=$TARGET_HOST"
    dropdb -h $TARGET_HOST -U postgres  --if-exists  -e $TARGET_DB;
fi

##Create DB
echo "Create database db=$TARGET_DB on host=$TARGET_HOST owned by $TARGET_OWNER"
createdb -h $TARGET_HOST -U "postgres" --owner=$TARGET_OWNER -e $TARGET_DB

##ON SOURCE DB AND TARGET DB =============================================
##Export import data
echo "Start export and import data from db=$FROM_DB host=$FROM_HOST to db=$TARGET_DB host=$TARGET_HOST"
PGPASSWORD=$FROM_PASS pg_dump -h $FROM_HOST -U postgres --no-owner --no-acl $FROM_DB | PGPASSWORD=$TARGET_OWNER_PASS psql -h $TARGET_HOST -U $TARGET_OWNER $TARGET_DB
