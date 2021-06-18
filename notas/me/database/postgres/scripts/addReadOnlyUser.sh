#!/bin/bash
echo "CONNECTING to -h $PGHOST -U postgres -p $PGPORT"
echo "USED parameters -h as PGHOST=$PGHOST ; -p as PGPORT=$PGPORT; -d as DB=$DB; NEWUSER_RO=$NEWUSER_RO; GRANTDB=$GRANTDB; NEWSCHEMA=$NEWSCHEMA; ROUSER=$ROUSER;"
#echo "Creating role \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER_RO\" with login nocreaterole nocreatedb nosuperuser password '$SECRET_RO';"
echo "Grant connect ON DATABASE \"$GRANTDB\" TO \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "GRANT CONNECT ON DATABASE \"$GRANTDB\" TO \"$NEWUSER_RO\";"
echo "fix public for \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "grant usage on schema public to \"$NEWUSER_RO\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "grant select on all tables IN SCHEMA public to \"$NEWUSER_RO\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select on tables to \"$NEWUSER_RO\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select, usage on sequences to \"$NEWUSER_RO\";"
echo "Fix rights as role set as OWNER=$OWNER"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "set role \"$OWNER\"; ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select on tables to \"$NEWUSER_RO\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "set role \"$OWNER\"; ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select, usage on sequences to \"$NEWUSER_RO\";"
echo "Fix rights connecting as OWNER=$OWNER"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $OWNER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select on tables to \"$NEWUSER_RO\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $OWNER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select, usage on sequences to \"$NEWUSER_RO\";"


echo "[INFO] Creating userlist entries"
./createUserlistEntry.sh

