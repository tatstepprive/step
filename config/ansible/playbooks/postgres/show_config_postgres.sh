#!/bin/bash

my_host=$1
echo "INFO: show hw on host=$my_host"

echo "Release info:"
#ansible $my_host -b -m shell -a "cat /etc/*release"
echo "Kernel info:"
#ansible $my_host -b -m shell -a "uname -r"
echo "IP info:"
#ansible $my_host -b -m shell -a "hostname -I"
echo "Processor info:"
#ansible $my_host -b -m shell -a "cat /proc/cpuinfo | grep processor"
echo "Memory info:"
#ansible $my_host -b -m shell -a "cat /proc/meminfo"
echo "Show connections sets:"
#ansible $my_host -b -m shell -a "cat /var/lib/pgsql/12/data/postgresql.conf| grep -i max_connection"
echo "Show prepared:"
#ansible $my_host -b -m shell -a "cat /var/lib/pgsql/12/data/postgresql.conf| grep -i prepared"
#ansible $my_host -b -m shell -a "cat /var/lib/pgsql/12/data/postgresql.conf| grep -i pool"
#ansible $my_host -b -m shell -a "cat /var/lib/pgsql/12/data/postgresql.conf| grep -i idle"
#ansible $my_host -b -m shell -a "cat /var/lib/pgsql/12/data/postgresql.conf"
ansible $my_host -b -m shell -a "cat /var/lib/pgsql/12/data/postgresql.conf | grep -i log"
ansible $my_host -b -m shell -a "cat /var/lib/pgsql/12/data/postgresql.conf | grep -i log_filename"

