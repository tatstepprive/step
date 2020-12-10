#!/bin/bash
PGUSER=${1:-"postgres"}

psql -U $PGUSER -c "SELECT * FROM pg_roles;"
