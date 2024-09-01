resource "google_cloud_scheduler_job" "job" {
  name             = "test-job"
  description      = "test http job"
  schedule         = "0 9 * * *"
  time_zone        = "Europe/London"
  attempt_deadline = "320s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "GET"
    uri         = "${google_cloud_run_v2_service.cloudrun_dbt.uri}/dbt/run"
    headers = {
      "Content-Type" = "application/json"
    }
    oidc_token {
      service_account_email = "cloud-scheduler-dbt@datalab-434211.iam.gserviceaccount.com"
    }
  }

  depends_on = [google_cloud_run_v2_service.cloudrun_dbt]
}