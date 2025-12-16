provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"
  labels = {
    project     = var.project_name
    environment = var.environment
    managedby   = "terraform"
    owner       = "jamiechristian"
  }
}
