terraform {
  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.primary_region

  default_tags {
    tags = local.common_tags
  }
}

provider "aws" {
  alias  = "dr"
  region = var.dr_region

  default_tags {
    tags = local.common_tags
  }
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "DisasterRecovery"
    Owner       = var.owner
  }
}

resource "aws_kms_key" "primary_backup" {
  description             = "KMS key for primary-region DR backups"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_key" "dr_backup" {
  provider                = aws.dr
  description             = "KMS key for DR-region backup copies"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_backup_vault" "primary" {
  name        = "${local.name_prefix}-primary-backup-vault"
  kms_key_arn = aws_kms_key.primary_backup.arn
}

resource "aws_backup_vault" "dr" {
  provider    = aws.dr
  name        = "${local.name_prefix}-dr-backup-vault"
  kms_key_arn = aws_kms_key.dr_backup.arn
}

resource "aws_backup_plan" "daily" {
  name = "${local.name_prefix}-daily-backup-plan"

  rule {
    rule_name         = "daily-retention"
    target_vault_name = aws_backup_vault.primary.name
    schedule          = var.backup_schedule
    start_window      = 60
    completion_window = 180

    lifecycle {
      cold_storage_after = var.cold_storage_after_days
      delete_after       = var.delete_after_days
    }

    copy_action {
      destination_vault_arn = aws_backup_vault.dr.arn

      lifecycle {
        cold_storage_after = var.cold_storage_after_days
        delete_after       = var.delete_after_days
      }
    }
  }
}

resource "aws_s3_bucket" "dr_artifacts_primary" {
  bucket = "${local.name_prefix}-dr-artifacts-primary-${var.unique_suffix}"
}

resource "aws_s3_bucket" "dr_artifacts_replica" {
  provider = aws.dr
  bucket   = "${local.name_prefix}-dr-artifacts-replica-${var.unique_suffix}"
}

resource "aws_s3_bucket_versioning" "primary" {
  bucket = aws_s3_bucket.dr_artifacts_primary.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "replica" {
  provider = aws.dr
  bucket   = aws_s3_bucket.dr_artifacts_replica.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "primary" {
  bucket = aws_s3_bucket.dr_artifacts_primary.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      kms_master_key_id = aws_kms_key.primary_backup.arn
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "replica" {
  provider = aws.dr
  bucket   = aws_s3_bucket.dr_artifacts_replica.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      kms_master_key_id = aws_kms_key.dr_backup.arn
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "backup_jobs_failed" {
  alarm_name          = "${local.name_prefix}-aws-backup-failed-jobs"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NumberOfBackupJobsFailed"
  namespace           = "AWS/Backup"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alert when AWS Backup jobs fail."
}
