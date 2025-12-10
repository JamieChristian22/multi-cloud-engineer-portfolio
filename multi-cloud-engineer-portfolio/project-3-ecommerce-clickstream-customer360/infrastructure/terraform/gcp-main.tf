provider "google" {
  project = var.project_id
  region  = var.region
}

// TODO: GCS buckets, BigQuery, Dataflow/Composer.
