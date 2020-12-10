#!/bin/bash

PGUSER=${1:-"postgres"}
echo "[INFO] on host=$PGHOST roles"
psql -U $PGUSER -c "\du;"

