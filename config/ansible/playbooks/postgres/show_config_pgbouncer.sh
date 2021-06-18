#!/bin/bash

my_host=$1
echo "INFO: show hw on host=$my_host"

echo "Release info:"
#ansible $my_host -s -m shell -a "cat /etc/*release"
echo "Kernel info:"
#ansible $my_host -s -m shell -a "uname -r"
echo "IP info:"
#ansible $my_host -s -m shell -a "hostname -I"
echo "Processor info:"
#ansible $my_host -s -m shell -a "cat /proc/cpuinfo | grep processor"
echo "Memory info:"
#ansible $my_host -s -m shell -a "cat /proc/meminfo"
echo "Show binary sets:"
#ansible $my_host -s -m shell -a "cat /etc/pgbouncer/pgbouncer.ini| grep -i max_client_conn"
ansible $my_host -s -m shell -a "cat /etc/pgbouncer/pgbouncer.ini| grep -i pool"
ansible $my_host -s -m shell -a "cat /etc/pgbouncer/pgbouncer.ini| grep -i idle"
ansible $my_host -s -m shell -a "cat /etc/pgbouncer/pgbouncer.ini"

