variable "name_prefix" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }

variable "task_execution_role_arn" { type = string }
variable "task_role_arn" { type = string }

variable "container_port" { type = number }
variable "log_group_name" { type = string }

variable "db_endpoint" { type = string }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string, sensitive = true }

variable "tags" { type = map(string) }
