#!/bin/bash

FROM_DB="fromDb"
FROM_HOST="fromHost"
TARGET_DB="toDb"
TARGET_HOST="toHost"

#Drop DB is exist
if psql -h $TARGET_HOST  -U "postgres" -lqt | cut -d \| -f 1 | grep -qw $TARGET_DB ; then
    psql -h $TARGET_HOST  -U "postgres" -d $TARGET_DB -c "SELECT pid, pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = current_database() AND pid <> pg_backend_pid();";
    dropdb -h $TARGET_HOST -U postgres  --if-exists  -e $TARGET_DB;
fi

#Create DB
createdb -h $TARGET_HOST -U "postgres" -e $TARGET_DB

#Export import data
pg_dump -h $FROM_HOST -U postgres $FROM_DB | psql -h $TARGET_HOST -U postgres $TARGET_DB
