resource "aws_backup_vault" "enterprise" {
  name = "enterprise-backup-vault"
}

resource "aws_backup_plan" "daily" {
  name = "enterprise-daily-backup-plan"
  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.enterprise.name
    schedule          = "cron(0 5 ? * * *)"
    lifecycle { delete_after = 30 }
  }
}

resource "aws_backup_selection" "ec2" {
  iam_role_arn = var.backup_role_arn
  name         = "enterprise-ec2-assignment"
  plan_id      = aws_backup_plan.daily.id
  resources    = var.ec2_instance_arns
}
