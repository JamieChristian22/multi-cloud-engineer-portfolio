resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Enable required APIs
resource "google_project_service" "services" {
  for_each = toset([
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com"
  ])
  service = each.value
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "app-${local.name_prefix}"
  description   = "Docker images for ${local.name_prefix}"
  format        = "DOCKER"
  depends_on    = [google_project_service.services]
  labels        = local.labels
}

resource "google_secret_manager_secret" "dbpass" {
  secret_id = "dbpass-${local.name_prefix}"
  replication { auto {} }
  depends_on = [google_project_service.services]
  labels     = local.labels
}

resource "google_secret_manager_secret_version" "dbpass_v" {
  secret      = google_secret_manager_secret.dbpass.id
  secret_data = var.db_password
}

resource "google_sql_database_instance" "pg" {
  name             = "pg-${local.name_prefix}-${random_string.suffix.result}"
  database_version = "POSTGRES_15"
  region           = var.region
  depends_on       = [google_project_service.services]

  settings {
    tier = "db-f1-micro"
    backup_configuration {
      enabled = true
    }
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "allow-all-dev"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "db" {
  name     = "appdb"
  instance = google_sql_database_instance.pg.name
}

resource "google_sql_user" "user" {
  name     = var.db_username
  instance = google_sql_database_instance.pg.name
  password = var.db_password
}

# Service account for Cloud Run
resource "google_service_account" "run_sa" {
  account_id   = "run-sa-${local.name_prefix}"
  display_name = "Cloud Run SA for ${local.name_prefix}"
}

resource "google_project_iam_member" "run_sa_secret_access" {
  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.run_sa.email}"
}

resource "google_cloud_run_v2_service" "app" {
  name     = "app-${local.name_prefix}"
  location = var.region
  depends_on = [google_project_service.services]

  template {
    service_account = google_service_account.run_sa.email

    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.repository_id}/app:latest"
      ports { container_port = var.container_port }

      env {
        name  = "PORT"
        value = tostring(var.container_port)
      }

      env { name = "DB_HOST" value = google_sql_database_instance.pg.public_ip_address }
      env { name = "DB_NAME" value = google_sql_database.db.name }
      env { name = "DB_USER" value = google_sql_user.user.name }

      env {
        name = "DB_PASS"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.dbpass.secret_id
            version = "latest"
          }
        }
      }
    }
  }
}

# Allow public access for demo
resource "google_cloud_run_service_iam_member" "public" {
  location = google_cloud_run_v2_service.app.location
  project  = var.project_id
  service  = google_cloud_run_v2_service.app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Basic monitoring alert: high 5xx responses (Cloud Run)
resource "google_monitoring_alert_policy" "http_5xx" {
  display_name = "Cloud Run 5xx - ${local.name_prefix}"
  combiner     = "OR"

  conditions {
    display_name = "5xx responses"
    condition_threshold {
      filter = "resource.type=\"cloud_run_revision\" AND metric.type=\"run.googleapis.com/request_count\" AND metric.label.response_code_class=\"5xx\""
      comparison = "COMPARISON_GT"
      duration   = "60s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_DELTA"
      }

      threshold_value = 10
    }
  }
}
