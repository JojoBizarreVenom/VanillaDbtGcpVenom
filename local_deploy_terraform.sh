docker build . -t dbt_test:latest --platform linux/amd64 &&\
docker tag dbt_test:latest europe-west1-docker.pkg.dev/datalab-434211/dbt-vanilla-repo/dbt-test:latest &&\
gcloud auth configure-docker europe-west1-docker.pkg.dev &&\
docker push europe-west1-docker.pkg.dev/datalab-434211/dbt-vanilla-repo/dbt-test:latest &&\
cd terraform && terraform apply --auto-approve -var "github_sha=latest"