resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 7
  tags                    = merge(var.tags, { Name = "${var.name_prefix}-rds-kms" })
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-db-subnets"
  subnet_ids = var.private_subnet_ids
  tags       = merge(var.tags, { Name = "${var.name_prefix}-db-subnet-group" })
}

resource "aws_security_group" "db" {
  name        = "${var.name_prefix}-db-sg"
  description = "Allow Postgres from app SG only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 5432
    to_port         = 5432
    security_groups = [var.app_security_group_id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.name_prefix}-db-sg" })
}

resource "aws_db_parameter_group" "this" {
  name   = "${var.name_prefix}-pg-params"
  family = "postgres15"

  parameter {
    name  = "log_statement"
    value = "none"
  }

  tags = var.tags
}

resource "aws_db_instance" "this" {
  identifier             = "${var.name_prefix}-postgres"
  engine                 = "postgres"
  engine_version         = "15.5"
  instance_class         = "db.t4g.micro"
  allocated_storage      = 20
  storage_encrypted      = true
  kms_key_id             = aws_kms_key.rds.arn
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  username               = var.db_username
  password               = var.db_password
  db_name                = "appdb"
  parameter_group_name   = aws_db_parameter_group.this.name

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false
  publicly_accessible     = false
  multi_az                = false

  tags = merge(var.tags, { Name = "${var.name_prefix}-postgres" })
}
