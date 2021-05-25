#!/bin/bash
echo "CONNECTING to -h $PGHOST -U postgres -p $PGPORT"
echo "[INFO] Creating role \"$NEWUSER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER\" with login nocreaterole nocreatedb nosuperuser password '$SECRET';"
echo "[INFO] Creating database \"$NEWDB\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "CREATE DATABASE \"$NEWDB\" OWNER \"$NEWUSER\";"
echo "[INFO] Revoke connect on database \"$NEWDB\" from public"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "REVOKE ALL ON DATABASE \"$NEWDB\" FROM PUBLIC;"
echo "[INFO] Grant connect on database \"$NEWDB\" to \"$NEWUSER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "GRANT CONNECT ON DATABASE \"$NEWDB\" TO \"$NEWUSER\";"
echo "[INFO] Creating role \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER_RO\" with login nocreaterole nocreatedb nosuperuser password '$SECRET_RO';"
echo "[INFO] Grant connect on database \"$NEWDB\" to \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "GRANT CONNECT ON DATABASE \"$NEWDB\" TO \"$NEWUSER_RO\";"
echo "[INFO] Grant usage on schema public \"$NEWDB\" to \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -U postgres -p $PGPORT -c "GRANT USAGE ON SCHEMA PUBLIC TO \"$NEWUSER_RO\";"

echo "[INFO] Grant select all tables ON DATABASE \"$NEWDB\" TO \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $NEWDB -U postgres -p $PGPORT -c "SET ROLE \"$NEWUSER\"; select current_user, session_user; GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO \"$NEWUSER_RO\";"
echo "[INFO] Alter default privileges select all tables ON DATABASE \"$NEWDB\" TO \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $NEWDB -U postgres -p $PGPORT -c "SET ROLE \"$NEWUSER\"; select current_user, session_user; ALTER DEFAULT PRIVILEGES IN SCHEMA PUBLIC GRANT SELECT ON TABLES TO \"$NEWUSER_RO\";"
echo "[INFO] Creating extentions"
echo "[INFO] Creating extention lo"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $NEWDB -U postgres -p $PGPORT -c "create extension if not exists lo;"
echo "[INFO] Creating extentions pg_stat_statements"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $NEWDB -U postgres -p $PGPORT -c "create extension if not exists pg_stat_statements;"

echo "[INFO] Creating userlist entries"
./createUserlistEntry.sh

echo "[INFO] Creating pgbouncer entries"
./createPgBouncerEntry.sh









