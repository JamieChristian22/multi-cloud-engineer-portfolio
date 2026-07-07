output "primary_backup_vault_name" {
  value = aws_backup_vault.primary.name
}

output "dr_backup_vault_name" {
  value = aws_backup_vault.dr.name
}

output "primary_dr_artifact_bucket" {
  value = aws_s3_bucket.dr_artifacts_primary.bucket
}

output "replica_dr_artifact_bucket" {
  value = aws_s3_bucket.dr_artifacts_replica.bucket
}
