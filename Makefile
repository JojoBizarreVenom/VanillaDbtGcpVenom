.PHONY: dbt_run dbt_run_full dbt_seed dbt_compile dbt_source_freshness dbt_snapshot dbt_test dbt_deps dbt_docs_generate dbt_docs_serve requirements requirements-test requirements-dev test pylint

dbt_run:
	dbt run --project-dir app/dbt_vanilla

dbt_run_full:
	dbt run --full-refresh --project-dir app/dbt_vanilla

dbt_seed:
	dbt seed --project-dir app/dbt_vanilla

dbt_compile:
	dbt compile --project-dir app/dbt_vanilla

dbt_source_freshness:
	dbt source freshness --project-dir app/dbt_vanilla

dbt_snapshot:
	dbt snapshot --project-dir app/dbt_vanilla

dbt_test:
	dbt test --project-dir app/dbt_vanilla

dbt_deps:
	dbt deps --project-dir app/dbt_vanilla

dbt_docs_generate:
	dbt docs generate --project-dir app/dbt_vanilla

dbt_docs_serve:
	dbt docs serve --project-dir app/dbt_vanilla

requirements:
	poetry export --without-hashes --without=dev,test --format=requirements.txt > requirements.txt

requirements-test:
	poetry export --without-hashes --only=test --format=requirements.txt > requirements-test.txt

requirements-dev:
	poetry export --without-hashes --only=dev --format=requirements.txt > requirements-dev.txt

test:
	pytest --cov=schema --cov=routers --cov-report term-missing -vv

pylint:
	pylint --generate-rcfile > .pylintrc