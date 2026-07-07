variable "location" { type = string }
variable "project_name" { type = string }
variable "environment" { type = string }
variable "vnet_address_space" { type = list(string) }
variable "subnets" { type = map(list(string)) }
variable "allowed_admin_cidr" { type = string }
