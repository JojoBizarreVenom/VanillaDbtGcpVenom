cd app/dbt_vanilla &&\
dbt deps --project-dir . --profiles-dir . --target local &&\ 
dbt debug --project-dir . --profiles-dir . --target local &&\ 
dbt run --project-dir . --profiles-dir . --target local &&\
dbt test --project-dir . --profiles-dir . --target local 
