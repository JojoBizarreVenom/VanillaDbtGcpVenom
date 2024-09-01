resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "dbt_vanilla"
  friendly_name               = "test"
  description                 = "This is a test dataset"
  location                    = var.location
}
