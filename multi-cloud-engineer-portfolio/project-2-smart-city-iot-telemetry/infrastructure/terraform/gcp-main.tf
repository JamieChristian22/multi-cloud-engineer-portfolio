provider "google" {
  project = var.project_id
  region  = var.region
}

// TODO: Pub/Sub topics, BigQuery datasets, etc.
