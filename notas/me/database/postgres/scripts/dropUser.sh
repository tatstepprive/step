#!/bin/bash
echo "CONNECTING to -h $PGHOST -U postgres -p $PGPORT"
#echo "Revoke privileges from role \"$MYUSER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM \"$MYUSER\" ;"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM \"$MYUSER\" ;"
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM \"$MYUSER\" ;"
echo "Drop user \"$MYUSER\""
PGPASSWORD=$PGPASSWORD psql -h $PGHOST -d $DB -U postgres -p $PGPORT -c "DROP USER \"$MYUSER\";"

