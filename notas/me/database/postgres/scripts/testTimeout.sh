#!/bin/sh

timeout 30 ./showAllRoles.sh
status=$?
if [ $status -eq 124 ] #timed out
then
    echo "Timeout"
    exit 0
fi
echo "No timeout"
exit $status
