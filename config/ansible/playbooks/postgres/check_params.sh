#!/bin/bash

for i in \
 hostname1 \
 hostname2 \
 hostname3; \
 do ssh  postgres@$i "echo '================='; echo i=$i; cat /etc/hostname; grep -i max_connect /var/lib/pgsql/12/data/postgresql.conf; grep -i max_prepared /var/lib/pgsql/12/data/postgresql.conf"; done;

