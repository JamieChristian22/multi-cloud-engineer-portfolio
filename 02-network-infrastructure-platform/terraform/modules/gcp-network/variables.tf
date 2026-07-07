variable "project_name" { type = string }
variable "environment" { type = string }
variable "subnets" {
  type = map(object({
    region = string
    cidr   = string
  }))
}
variable "allowed_admin_cidr" { type = string }
