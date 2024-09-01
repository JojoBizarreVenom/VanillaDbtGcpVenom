resource "google_cloud_run_v2_service" "cloudrun_dbt" {
  name     = "cloudrun-dbt-service-venom"
  location = var.region
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"
  template {
    service_account = "dbt-service-vanilla-venom@datalab-434211.iam.gserviceaccount.com"
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.my-repo.repository_id}/dbt-test:${var.github_sha}"
      ports {
        container_port = 8080
      }
      volume_mounts {
        name = "a-volume"
        mount_path = "/secrets"
      }
    }
    volumes {
      name = "a-volume"
      secret {
        secret = "dbt-service-keyfile"
        default_mode = 292 # 0444
        items {
          version = "latest"
          path = "dbt-service-keyfile"
        }
      }
    }
  }

  depends_on = [google_artifact_registry_repository.my-repo]
}

