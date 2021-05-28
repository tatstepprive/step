#!/bin/bash
echo "CONNECTING to -h $PGHOST -U postgres -p $PGPORT"

echo "[INFO] Revoke connect from template1"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "REVOKE CONNECT ON DATABASE template1 FROM PUBLIC;"

##echo "[INFO] Creating role superuser \"$NEWUSER_MIG_SUPER\""
##PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER_MIG_SUPER\" with login replication superuser password '$SECRET_MIG_SUPER';"
##echo "[INFO] Creating role \"$NEWUSER_MIG_DEV\""
##PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER_MIG_DEV\" with login nocreaterole nocreatedb nosuperuser password '$SECRET_MIG_DEV';"
##echo "[INFO] Creating role \"$NEWUSER_MIG_ACC\""
##PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER_MIG_ACC\" with login nocreaterole nocreatedb nosuperuser password '$SECRET_MIG_ACC';"
##echo "[INFO] Creating role \"$NEWUSER_MIG_TST\""
##PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER_MIG_TST\" with login nocreaterole nocreatedb nosuperuser password '$SECRET_MIG_TST';"

echo "[INFO] Creating database \"$NEWDB\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "CREATE DATABASE \"$NEWDB\" OWNER \"$NEWUSER_MIG_SUPER\";"

echo "[INFO] Creating schema \"$NEW_SCHEMA_DEV\" as \"$NEWUSER_MIG_SUPER\""
PGPASSWORD=$SECRET_MIG_SUPER psql -h $PGHOST -U $NEWUSER_MIG_SUPER -p $PGPORT -d $NEWDB -c "CREATE SCHEMA \"$NEW_SCHEMA_DEV\" AUTHORIZATION \"$NEWUSER_MIG_DEV\";"
echo "[INFO] Creating schema \"$NEW_SCHEMA_ACC\" as \"$NEWUSER_MIG_SUPER\""
PGPASSWORD=$SECRET_MIG_SUPER psql -h $PGHOST -U $NEWUSER_MIG_SUPER -p $PGPORT -d $NEWDB -c "CREATE SCHEMA \"$NEW_SCHEMA_ACC\" AUTHORIZATION \"$NEWUSER_MIG_ACC\";"
echo "[INFO] Creating schema \"$NEW_SCHEMA_TST\" as \"$NEWUSER_MIG_SUPER\""
PGPASSWORD=$SECRET_MIG_SUPER psql -h $PGHOST -U $NEWUSER_MIG_SUPER -p $PGPORT -d $NEWDB -c "CREATE SCHEMA \"$NEW_SCHEMA_TST\" AUTHORIZATION \"$NEWUSER_MIG_TST\";"

echo "[INFO] Change search_path for \"$NEWUSER_MIG_SUPER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "ALTER ROLE \"$NEWUSER_MIG_SUPER\" SET search_path TO \"$NEW_SCHEMA_DEV\", \"$NEW_SCHEMA_ACC\", \"$NEW_SCHEMA_TST\", public;"
echo "[INFO] Change search_path for \"$NEWUSER_MIG_DEV\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "ALTER ROLE \"$NEWUSER_MIG_DEV\" SET search_path TO \"$NEW_SCHEMA_DEV\", public;"
echo "[INFO] Change search_path for \"$NEWUSER_MIG_ACC\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "ALTER ROLE \"$NEWUSER_MIG_ACC\" SET search_path TO \"$NEW_SCHEMA_ACC\", public;"
echo "[INFO] Change search_path for \"$NEWUSER_MIG_TST\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "ALTER ROLE \"$NEWUSER_MIG_TST\" SET search_path TO \"$NEW_SCHEMA_TST\", public;"


echo "[INFO] Creating extentions"
echo "[INFO] Creating extention lo"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $NEWDB -U postgres -p $PGPORT -c "create extension if not exists lo;"
echo "[INFO] Creating extentions pg_stat_statements"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $NEWDB -U postgres -p $PGPORT -c "create extension if not exists pg_stat_statements;"

###echo "[INFO] Creating userlist entries"
###./createUserlistEntry.sh

###echo "[INFO] Creating pgbouncer entries"
###./createPgBouncerEntry.sh









