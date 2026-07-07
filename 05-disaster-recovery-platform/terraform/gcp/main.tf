terraform {
  required_version = ">= 1.6.0"
}

provider "google" {
  project = var.project_id
  region  = var.primary_region
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"
  labels = {
    project     = replace(var.project_name, "-", "_")
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "disaster_recovery"
  }
}

resource "google_storage_bucket" "dr_artifacts_primary" {
  name                        = "${local.name_prefix}-dr-artifacts-primary-${var.unique_suffix}"
  location                    = var.primary_region
  uniform_bucket_level_access = true
  force_destroy               = var.force_destroy
  labels                      = local.labels

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = var.archive_after_days
    }
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
  }

  lifecycle_rule {
    condition {
      age = var.delete_after_days
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket" "dr_artifacts_replica" {
  name                        = "${local.name_prefix}-dr-artifacts-replica-${var.unique_suffix}"
  location                    = var.dr_region
  uniform_bucket_level_access = true
  force_destroy               = var.force_destroy
  labels                      = local.labels

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "backup_repository" {
  name                        = "${local.name_prefix}-backup-repository-${var.unique_suffix}"
  location                    = var.multi_region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = var.force_destroy
  labels                      = local.labels

  versioning {
    enabled = true
  }
}

resource "google_logging_project_sink" "dr_audit_sink" {
  name        = "${local.name_prefix}-dr-audit-sink"
  destination = "storage.googleapis.com/${google_storage_bucket.backup_repository.name}"

  filter = "resource.type=(\"gce_instance\" OR \"gcs_bucket\") AND severity>=WARNING"
}

resource "google_project_iam_member" "sink_writer" {
  project = var.project_id
  role    = "roles/storage.objectCreator"
  member  = google_logging_project_sink.dr_audit_sink.writer_identity
}

resource "google_monitoring_notification_channel" "email" {
  count        = var.notification_email == "" ? 0 : 1
  display_name = "DR Operations Email"
  type         = "email"

  labels = {
    email_address = var.notification_email
  }
}
