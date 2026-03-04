#!/usr/bin/env bash

export PGHOST=localhost
export PHGPORT=5432
export PGUSER=postgres
export PGPASSWORD=test1234
export PGDATABASE=postgres

psql -f ./test/init.sql
