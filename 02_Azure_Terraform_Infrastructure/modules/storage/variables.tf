variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "storage_account_name" { type = string }
variable "blob_container_name" { type = string }
variable "tfstate_container" { type = string }
variable "tags" { type = map(string) }
