output "artifact_registry_repo" {
  value       = google_artifact_registry_repository.repo.repository_id
  description = "Artifact Registry repo id"
}

output "cloud_sql_instance" {
  value       = google_sql_database_instance.pg.name
  description = "Cloud SQL instance name"
}

output "service_url" {
  value       = google_cloud_run_v2_service.app.uri
  description = "Cloud Run service URL"
}
