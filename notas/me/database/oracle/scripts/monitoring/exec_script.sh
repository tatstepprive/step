#!/bin/bash
MY_HOST=$ORAHOST
MY_SID=$ORASID
MY_USER=$ORAUSER
MY_PASS=$ORAPASSWORD
MY_SCRIPT="@simple.sql"

while true ; do
  case "$1" in
    --host) shift; MY_HOST=$1; shift;;
    --sid) shift; MY_SID=$1; shift;;
    --user) shift; MY_USER=$1; shift;;
    --pass) shift; MY_PASS=$1; shift;;
    --script) shift; MY_SCRIPT=@$1; shift;;
    *) break;;
  esac
done

DB_CONNECT_STRING="(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$MY_HOST)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=$MY_SID)))"
sqlplus -S  "$MY_USER/$MY_PASS@$DB_CONNECT_STRING" <<EOF
	$MY_SCRIPT
EOF
