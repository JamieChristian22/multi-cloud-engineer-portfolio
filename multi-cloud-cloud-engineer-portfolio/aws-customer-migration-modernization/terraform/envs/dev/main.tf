module "vpc" {
  source      = "../../modules/vpc"
  name_prefix = local.name_prefix
  cidr_block  = "10.20.0.0/16"
  az_count    = 2
  tags        = local.common_tags
}

module "observability" {
  source      = "../../modules/observability"
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

module "iam" {
  source      = "../../modules/iam"
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

module "rds" {
  source              = "../../modules/rds_postgres"
  name_prefix          = local.name_prefix
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  db_username          = var.db_username
  db_password          = var.db_password
  app_security_group_id = module.ecs.app_sg_id
  tags                = local.common_tags
}

module "ecs" {
  source             = "../../modules/ecs_fargate"
  name_prefix        = local.name_prefix
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  task_execution_role_arn = module.iam.task_execution_role_arn
  task_role_arn           = module.iam.task_role_arn

  container_port  = var.app_container_port
  log_group_name  = module.observability.app_log_group_name

  db_endpoint = module.rds.db_endpoint
  db_name     = module.rds.db_name
  db_username = var.db_username
  db_password = var.db_password

  tags = local.common_tags
}
