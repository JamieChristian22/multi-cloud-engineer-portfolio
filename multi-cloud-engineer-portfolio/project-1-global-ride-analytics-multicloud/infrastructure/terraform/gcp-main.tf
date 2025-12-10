provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "global_ride_raw" {
  name          = var.gcs_raw_bucket_name
  location      = var.region
  force_destroy = true
}

// TODO: BigQuery dataset, tables, Dataflow/Composer.
