#!/bin/bash
 ./showDbs.sh | tail -n +4 |grep -v rows| grep -v template| grep -v ^$ | sed 's/\|/ /'|awk '{print $1}'
