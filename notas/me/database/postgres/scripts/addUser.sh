#!/bin/bash
echo "CONNECTING to -h $PGHOST -U postgres -p $PGPORT"
echo "USED parameters -h as PGHOST=$PGHOST ; -p as PGPORT=$PGPORT; -d as DB=$DB; NEWUSER=$NEWUSER; GRANTDB=$GRANTDB; NEWSCHEMA=$NEWSCHEMA; ROUSER=$ROUSER; ADMIN_USER=$ADMIN_USER"
#echo "Creating role \"$NEWUSER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER\" with login nocreaterole nocreatedb nosuperuser password '$SECRET';"
echo "Grant connect ON DATABASE \"$GRANTDB\" TO \"$NEWUSER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "GRANT CONNECT ON DATABASE \"$GRANTDB\" TO \"$NEWUSER\";"
echo "Creating schema \"$NEWSCHEMA\" AUTHORIZATION \"$NEWUSER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "CREATE SCHEMA \"$NEWSCHEMA\" AUTHORIZATION \"$NEWUSER\";"
echo "Set search path to  \"$NEWSCHEMA\", public"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "alter role \"$NEWUSER\" set search_path to \"$NEWSCHEMA\", public;"
echo "Grant ADMIN usage on schema \"$NEWSCHEMA\" for user \"$ADMIN_USER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "grant usage on schema \"$NEWSCHEMA\" to \"$ADMIN_USER\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $NEWUSER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant all on tables to \"$ADMIN_USER\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $NEWUSER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select, usage on sequences to \"$ADMIN_USER\";"
echo "Grant RO usage on schema \"$NEWSCHEMA\" for user \"$ROUSER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "grant usage on schema \"$NEWSCHEMA\" to \"$ROUSER\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $NEWUSER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select on tables to \"$ROUSER\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $NEWUSER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select, usage on sequences to \"$ROUSER\";"
echo "fix public for  \"$NEWUSER\""
#PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "revoke all on schema public from PUBLIC;"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "grant usage on schema public to \"$NEWUSER\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select on tables to \"$NEWUSER\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select, usage on sequences to \"$NEWUSER\";"
echo "Fix rights as role set as NEWUSER=$NEWUSER"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "set role \"$NEWUSER\"; ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select on tables to \"$ROUSER\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "set role \"$NEWUSER\"; ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select, usage on sequences to \"$ROUSER\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "set role \"$NEWUSER\"; ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant all on tables to \"$ADMIN_USER\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "set role \"$NEWUSER\"; ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select, usage on sequences to \"$ADMIN_USER\";"
echo "Fix rights connecting as NEWUSER=$NEWUSER"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $NEWUSER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select on tables to \"$ROUSER\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $NEWUSER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select, usage on sequences to \"$ROUSER\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $NEWUSER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant all on tables to \"$ADMIN_USER\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $NEWUSER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA \"$NEWSCHEMA\" grant select, usage on sequences to \"$ADMIN_USER\";"


echo "[INFO] Creating userlist entries"
./createUserlistEntry.sh
