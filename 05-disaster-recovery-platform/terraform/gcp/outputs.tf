output "primary_dr_artifacts_bucket" { value = google_storage_bucket.dr_artifacts_primary.name }
output "replica_dr_artifacts_bucket" { value = google_storage_bucket.dr_artifacts_replica.name }
output "backup_repository_bucket" { value = google_storage_bucket.backup_repository.name }
output "dr_audit_sink_name" { value = google_logging_project_sink.dr_audit_sink.name }
