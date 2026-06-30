resource "google_compute_resource_policy" "daily_snapshot" {
  name   = "enterprise-daily-snapshot-policy"
  region = var.region

  snapshot_schedule_policy {
    schedule { daily_schedule { days_in_cycle = 1 start_time = "05:00" } }
    retention_policy { max_retention_days = 14 on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS" }
    snapshot_properties { storage_locations = [var.region] }
  }
}
