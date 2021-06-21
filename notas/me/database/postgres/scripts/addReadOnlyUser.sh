#!/bin/bash
echo "CONNECTING to -h $PGHOST -U postgres -p $PGPORT"
echo "USED parameters -h as PGHOST=$PGHOST ; -p as PGPORT=$PGPORT; -d as DB=$DB; NEWUSER_RO=$NEWUSER_RO; GRANTDB=$GRANTDB; NEWSCHEMA=$NEWSCHEMA; ROUSER=$ROUSER;"
echo "Creating role \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "CREATE ROLE \"$NEWUSER_RO\" with login nocreaterole nocreatedb nosuperuser password '$SECRET_RO';"

#Start FIX public schema rights (single schema db, stop read only-user from creating tables in public schema)
echo "REVOKE ALL ON SCHEMA public FROM public"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "REVOKE ALL ON SCHEMA public FROM public;"
echo "GRANT ALL ON SCHEMA public TO \"$OWNER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "GRANT ALL ON SCHEMA public TO \"$OWNER\";"
#End FIX public schema rights

echo "Grant connect ON DATABASE \"$GRANTDB\" TO \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "GRANT CONNECT ON DATABASE \"$GRANTDB\" TO \"$NEWUSER_RO\";"

#Start FIX permission to list tables (i.e. \d returns no results)
echo "Permission to list tables for \"$NEWUSER_RO\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "grant usage on schema public to \"$NEWUSER_RO\";"
#End FIX permission to list tables (i.e. \d returns no results)

#Start FIX select rights
echo "Fix select rights for OWNER=$OWNER"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "grant select on all tables IN SCHEMA public to \"$NEWUSER_RO\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select on tables to \"$NEWUSER_RO\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select, usage on sequences to \"$NEWUSER_RO\";"
echo "Fix select rights as role set as OWNER=$OWNER"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "set role \"$OWNER\"; ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select on tables to \"$NEWUSER_RO\";"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $GRANTDB -U postgres -p $PGPORT -c "set role \"$OWNER\"; ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select, usage on sequences to \"$NEWUSER_RO\";"
echo "Fix select rights connecting as OWNER=$OWNER"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $OWNER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select on tables to \"$NEWUSER_RO\";"
PGPASSWORD=$SECRET psql -h $PGHOST -d $GRANTDB -U $OWNER -p $PGPORT -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public grant select, usage on sequences to \"$NEWUSER_RO\";"


echo "[INFO] Creating userlist entries"
./createUserlistEntry.sh

