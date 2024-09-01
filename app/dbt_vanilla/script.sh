#!/bin/sh
dbt deps --profiles-dir .
dbt debug --profiles-dir .
dbt test --profiles-dir .
dbt run --profiles-dir .
