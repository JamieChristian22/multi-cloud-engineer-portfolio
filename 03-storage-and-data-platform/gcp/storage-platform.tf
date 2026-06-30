resource "google_storage_bucket" "data" {
  name                        = "jc-enterprise-data-platform"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  versioning { enabled = true }
  lifecycle_rule {
    condition { age = 30 }
    action { type = "SetStorageClass" storage_class = "NEARLINE" }
  }
  lifecycle_rule {
    condition { num_newer_versions = 3 }
    action { type = "Delete" }
  }
}
